/// Handles the interactive command-line interface for cluster management
struct InteractiveMenu {
    private let cluster: Cluster
    private let serviceRequirements: [String: (cpu: Int, ram: Int)]
    
    init(cluster: Cluster, serviceRequirements: [String: (cpu: Int, ram: Int)]) {
        self.cluster = cluster
        self.serviceRequirements = serviceRequirements
    }
    
    /// Displays the main menu and handles user input
    func showMainMenu() {
        while true {
            print("\n=== Kubernetes Cluster Management Tool ===")
            print("1. Container Status Management")
            print("2. Resource Management")
            print("3. Container Operations")
            print("4. Exit")
            print("\nEnter your choice (1-4): ")
            
            guard let choice = readLine() else { continue }
            
            switch choice {
            case "1":
                showContainerStatusMenu()
            case "2":
                showResourceManagementMenu()
            case "3":
                showContainerOperationsMenu()
            case "4":
                print("Exiting...")
                return
            default:
                print("Invalid choice. Please try again.")
            }
        }
    }
    
    /// Shows container status management options
    private func showContainerStatusMenu() {
        while true {
            print("\n=== Container Status Management ===")
            print("1. View all container statuses")
            print("2. View cluster summary")
            print("3. Count containers by type")
            print("4. Back to main menu")
            print("\nEnter your choice (1-4): ")
            
            guard let choice = readLine() else { continue }
            
            switch choice {
            case "1":
                displayContainerStatus(cluster: cluster)
            case "2":
                clusterSummary(cluster: cluster)
            case "3":
                print("Enter container type to count: ")
                if let type = readLine() {
                    let count = countContainers(ofType: type, in: cluster)
                    print("\nFound \(count) containers of type '\(type)'")
                }
            case "4":
                return
            default:
                print("Invalid choice. Please try again.")
            }
        }
    }
    
    /// Shows resource management options
    private func showResourceManagementMenu() {
        while true {
            print("\n=== Resource Management ===")
            print("1. View pod resources")
            print("2. Check available resources for a node")
            print("3. Calculate service resources")
            print("4. Back to main menu")
            print("\nEnter your choice (1-4): ")
            
            guard let choice = readLine() else { continue }
            
            switch choice {
            case "1":
                displayPodResources(cluster: cluster)
            case "2":
                print("Enter node ID: ")
                if let input = readLine(), let nodeId = Int(input) {
                    displayAvailableResources(forNodeId: nodeId, cluster: cluster)
                } else {
                    print("Invalid node ID")
                }
            case "3":
                print("Enter service type: ")
                if let type = readLine() {
                    let resources = calculateResourcesForService(typeName: type, in: cluster)
                    print("\nService '\(type)' uses:")
                    print("- CPU: \(resources.cpu)")
                    print("- RAM: \(resources.ram)")
                }
            case "4":
                return
            default:
                print("Invalid choice. Please try again.")
            }
        }
    }
    
    /// Shows container operations options
    private func showContainerOperationsMenu() {
        while true {
            print("\n=== Container Operations ===")
            print("1. Restart all crashed containers")
            print("2. Restart specific container")
            print("3. View service requirements")
            print("4. Back to main menu")
            print("\nEnter your choice (1-4): ")
            
            guard let choice = readLine() else { continue }
            
            switch choice {
            case "1":
                var mutableCluster = cluster
                restartAllCrashedContainers(
                    serviceRequirements: serviceRequirements,
                    cluster: &mutableCluster
                )
            case "2":
                print("Enter container name to restart: ")
                if let name = readLine() {
                    var mutableCluster = cluster
                    let success = restartCrashedContainer(
                        containerName: name,
                        serviceRequirements: serviceRequirements,
                        cluster: &mutableCluster
                    )
                    if success {
                        print("Container successfully restarted")
                    } else {
                        print("Failed to restart container")
                    }
                }
            case "3":
                print("\nService Requirements:")
                for (service, requirements) in serviceRequirements {
                    print("- \(service):")
                    print("  CPU: \(requirements.cpu)")
                    print("  RAM: \(requirements.ram)")
                }
            case "4":
                return
            default:
                print("Invalid choice. Please try again.")
            }
        }
    }
} 