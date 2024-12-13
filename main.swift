import Foundation

let serviceRequirements: [String: (cpu: Int, ram: Int)] = [
    "postgres_db": (2, 8),
    "kafka_broker": (4, 16),
    "redis_cache": (1, 2),
    "nginx_webserver": (2, 8),
    "fluentd_logger": (2, 4),
    "api_service": (1, 2),
    "spark_worker": (4, 16),
    "mongodb": (2, 10),
    "frontend": (1, 2),
    "mysql_db": (3, 10),
    "auth_service": (2, 6),
    "logger": (1, 1),
    "backend_service": (2, 6),
    "job_scheduler": (3, 6),
    "alerting_service": (1, 1),
    "elasticsearch": (1, 20),
    "logstash": (3, 10),
    "monitoring_agent": (2, 4),
    "data_processor": (2, 8),
    "grafana_monitoring": (2, 4),
    "alert_manager": (1, 1),
    "prometheus": (3, 6),
]

@main
struct App {

    static func main() {
        // Example usage
        if let fileContent = try? String(
            contentsOfFile: "./kube_status.txt",
            encoding: .utf8)
        {
            var cluster = parseClusterStatus(fileContent: fileContent)
            print("Cluster Status avant le redémarrage :")
            displayContainerStatus(cluster: cluster)
            restartAllCrashedContainers(serviceRequirements: serviceRequirements, cluster: &cluster)

            let containerName = "redis_cache"
            let success = restartCrashedContainer(
                containerName: containerName,
                serviceRequirements: serviceRequirements,
                cluster: &cluster
            )

            if success {
                print("Container \(containerName) was restarted successfully.")
            } else {
                print("Failed to restart container \(containerName).")
            }
            displayPodResources(cluster: cluster)
            clusterSummary(cluster: cluster)

            // Afficher les ressources disponibles sur un nœud spécifique
            let nodeIdToCheck = 1  // Remplacez par l'ID du nœud que vous voulez vérifier
            displayAvailableResources(forNodeId: nodeIdToCheck, cluster: cluster)
            print("Enter the name of the container type to count:")
            if let userInput = readLine() {
                let count = countContainers(ofType: userInput, in: cluster)
                print("There are \(count) containers of type '\(userInput)' in the cluster.")
            }

            print("Enter the name of the service type to calculate resources for:")
            if let userInput = readLine() {
                let resources = calculateResourcesForService(typeName: userInput, in: cluster)
                print(
                    "The service '\(userInput)' is using \(resources.cpu) CPUs and \(resources.ram) RAM in total."
                )
            }
        }
    }

}
