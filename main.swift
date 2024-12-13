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
        if let fileContent = try? String(contentsOfFile: "./kube_status.txt", encoding: .utf8) {
            let cluster = parseClusterStatus(fileContent: fileContent)
            let menu = InteractiveMenu(cluster: cluster, serviceRequirements: serviceRequirements)
            menu.showMainMenu()
        } else {
            print("Error: Could not read kube_status.txt file")
        }
    }

}
