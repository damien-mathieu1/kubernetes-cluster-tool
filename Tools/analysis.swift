/// Displays the current status of all containers in the cluster
/// - Parameter cluster: The cluster to analyze
func displayContainerStatus(cluster: Cluster) {
    for node in cluster.nodes {
        for pod in node.pods {
            for container in pod.containers {
                switch container.status {
                case .running:
                    print(
                        "Le conteneur \(container.name) dans Pod \(pod.id) sur Node \(node.id) fonctionne normalement."
                    )
                case .stopped:
                    print(
                        "Le conteneur \(container.name) dans Pod \(pod.id) sur Node \(node.id) est arrêté."
                    )
                case .crashed:
                    print(
                        "Le conteneur \(container.name) dans Pod \(pod.id) sur Node \(node.id) a crashé."
                    )
                }
            }
        }
    }
}

/// Calculates the total CPU and RAM resources used by a pod
/// - Parameter pod: The pod to analyze
/// - Returns: A tuple containing the total CPU and RAM usage
func calculatePodResources(pod: Pod) -> (cpu: Int, ram: Int) {
    let cpu = pod.containers.reduce(0) { $0 + $1.cpu }
    let ram = pod.containers.reduce(0) { $0 + $1.ram }
    return (cpu, ram)
}

/// Displays resource usage for all pods in the cluster
/// - Parameter cluster: The cluster to analyze
func displayPodResources(cluster: Cluster) {
    for node in cluster.nodes {
        for pod in node.pods {
            let (cpu, ram) = calculatePodResources(pod: pod as! Pod)
            print("Pod \(pod.id) on Node \(node.id) uses \(cpu) CPUs and \(ram) RAM.")
        }
    }
}

/// Generates a summary of container statuses across the cluster
/// - Parameter cluster: The cluster to analyze
func clusterSummary(cluster: Cluster) {
    var runningCount = 0
    var stoppedCount = 0
    var crashedCount = 0

    for node in cluster.nodes {
        for pod in node.pods {
            for container in pod.containers {
                switch container.status {
                case .running:
                    runningCount += 1
                case .stopped:
                    stoppedCount += 1
                case .crashed:
                    crashedCount += 1
                }
            }
        }
    }

    print("Cluster Summary:")
    print("- Running Containers: \(runningCount)")
    print("- Stopped Containers: \(stoppedCount)")
    print("- Crashed Containers: \(crashedCount)")
}

/// Calculates available resources on a specific node
/// - Parameter node: The node to analyze
/// - Returns: A tuple containing available CPU and RAM
func availableResources(node: Node) -> (cpu: Int, ram: Int) {
    let usedCPU = node.pods.flatMap { $0.containers }.reduce(0) { $0 + $1.cpu }
    let usedRAM = node.pods.flatMap { $0.containers }.reduce(0) { $0 + $1.ram }
    return (node.cpu - usedCPU, node.ram - usedRAM)
}

/// Displays available resources for a specific node
/// - Parameters:
///   - nodeId: The ID of the node to analyze
///   - cluster: The cluster containing the node
func displayAvailableResources(forNodeId nodeId: Int, cluster: Cluster) {
    if let node = cluster.nodes.first(where: { $0.id == nodeId }) {
        let (availableCPU, availableRAM) = availableResources(node: node as! Node)
        print("Node \(nodeId):")
        print("- Available CPUs: \(availableCPU)")
        print("- Available RAM: \(availableRAM)")
    } else {
        print("Node with ID \(nodeId) not found in the cluster.")
    }
}

/// Counts containers of a specific type in the cluster
/// - Parameters:
///   - typeName: The type of container to count
///   - cluster: The cluster to analyze
/// - Returns: The number of containers of the specified type
func countContainers(ofType typeName: String, in cluster: Cluster) -> Int {
    var count = 0

    for node in cluster.nodes {
        for pod in node.pods {
            for container in pod.containers {
                if container.name == typeName {
                    count += 1
                }
            }
        }
    }

    return count
}

/// Calculates total resources used by containers of a specific type
/// - Parameters:
///   - typeName: The type of container to analyze
///   - cluster: The cluster to analyze
/// - Returns: A tuple containing total CPU and RAM usage
func calculateResourcesForService(typeName: String, in cluster: Cluster) -> (cpu: Int, ram: Int) {
    var totalCPU = 0
    var totalRAM = 0

    for node in cluster.nodes {
        for pod in node.pods {
            for container in pod.containers {
                if container.name == typeName {
                    totalCPU += container.cpu
                    totalRAM += container.ram
                }
            }
        }
    }

    return (totalCPU, totalRAM)
}
