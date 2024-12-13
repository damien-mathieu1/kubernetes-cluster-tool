import Foundation

func loadServiceRequirements() -> [String: (cpu: Int, ram: Int)] {
    // Use Bundle.main instead of Bundle.module, and provide a fallback path
    let configPath = Bundle.main.path(forResource: "service_requirements", ofType: "json") ??
        "./Config/service_requirements.json"
    
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: configPath))
        // Explicitly cast the JSON structure
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: [String: Any]] else {
            fatalError("Invalid JSON format")
        }
        
        var requirements: [String: (cpu: Int, ram: Int)] = [:]
        for (service, resources) in json {
            // Cast the values to Int
            if let cpu = resources["cpu"] as? Int,
               let ram = resources["ram"] as? Int {
                requirements[service] = (cpu: cpu, ram: ram)
            }
        }
        return requirements
    } catch {
        fatalError("Error loading service requirements: \(error)")
    }
}

@main
struct App {

    static func main() {
        if let fileContent = try? String(contentsOfFile: "./kube_status.txt", encoding: .utf8) {
            let cluster = parseClusterStatus(fileContent: fileContent)
            let menu = InteractiveMenu(cluster: cluster, serviceRequirements: loadServiceRequirements())
            menu.showMainMenu()
        } else {
            print("Error: Could not read kube_status.txt file")
        }
    }

}
