/// Attempts to restart all crashed containers in the cluster
/// - Parameters:
///   - serviceRequirements: Dictionary of resource requirements for each service type
///   - cluster: The cluster to manage (passed as inout for modification)
func restartAllCrashedContainers(
    serviceRequirements: [String: (cpu: Int, ram: Int)],
    cluster: inout Cluster
) {
    var restartedContainers: [String] = []
    var failedContainers: [String] = []

    for nodeIndex in cluster.nodes.indices {
        let node = cluster.nodes[nodeIndex] as! Node
        var (availableCPU, availableRAM) = availableResources(node: node)

        for podIndex in cluster.nodes[nodeIndex].pods.indices {
            var pod = cluster.nodes[nodeIndex].pods[podIndex] as! Pod

            for containerIndex in pod.containers.indices {
                var container = pod.containers[containerIndex]

                if container.status == .crashed {
                    if let requirements = serviceRequirements[container.name],
                        requirements.cpu <= availableCPU,
                        requirements.ram <= availableRAM
                    {
                        container.status = .running
                        container.cpu = requirements.cpu
                        container.ram = requirements.ram
                        pod.containers[containerIndex] = container
                        cluster.nodes[nodeIndex].pods[podIndex] = pod

                        availableCPU -= requirements.cpu
                        availableRAM -= requirements.ram
                        restartedContainers.append(container.name)
                    } else {
                        // Ressources insuffisantes
                        failedContainers.append(container.name)
                    }
                }
            }
        }
    }

    if !restartedContainers.isEmpty {
        print(
            "Containers restarted successfully: \(restartedContainers.joined(separator: ", "))")
    }
    if !failedContainers.isEmpty {
        print(
            "Failed to restart containers due to insufficient resources: \(failedContainers.joined(separator: ", "))"
        )
    }
}

/// Attempts to restart a specific crashed container
/// - Parameters:
///   - containerName: Name of the container to restart
///   - serviceRequirements: Dictionary of resource requirements for each service type
///   - cluster: The cluster to manage (passed as inout for modification)
/// - Returns: Boolean indicating whether the restart was successful
func restartCrashedContainer(
    containerName: String,
    serviceRequirements: [String: (cpu: Int, ram: Int)],
    cluster: inout Cluster
) -> Bool {
    for nodeIndex in cluster.nodes.indices {
        let node = cluster.nodes[nodeIndex] as! Node
        let (availableCPU, availableRAM) = availableResources(node: node)

        for podIndex in cluster.nodes[nodeIndex].pods.indices {
            var pod = cluster.nodes[nodeIndex].pods[podIndex] as! Pod

            for containerIndex in pod.containers.indices {
                var container = pod.containers[containerIndex]
                if container.name == containerName && container.status == .crashed {
                    if let requirements = serviceRequirements[container.name] {
                        if requirements.cpu <= availableCPU && requirements.ram <= availableRAM {
                            // Ressources disponibles, redémarrage du conteneur
                            container.status = .running
                            container.cpu = requirements.cpu
                            container.ram = requirements.ram
                            pod.containers[containerIndex] = container
                            cluster.nodes[nodeIndex].pods[podIndex] = pod
                            print(
                                "Container \(container.name) restarted successfully on Node \(node.id)."
                            )
                            return true
                        } else {
                            // Ressources insuffisantes
                            print(
                                "Error: Insufficient resources to restart \(container.name) on Node \(node.id)."
                            )
                            return false
                        }
                    }
                }
            }
        }
    }
    // Conteneur introuvable ou non en état "crashed"
    print("Error: Container \(containerName) not found or not in crashed state.")
    return false
}
