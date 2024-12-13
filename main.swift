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

func loadClusterStatus() -> String {
    while true {
        print("\nEnter the path to your cluster status file (default: ./kube_status.txt):")
        let input = readLine()?.trimmingCharacters(in: .whitespaces) ?? ""
        let path = input.isEmpty ? "./kube_status.txt" : input
        
        if let fileContent = try? String(contentsOfFile: path, encoding: .utf8) {
            return fileContent
        } else {
            print("Error: Could not read file at path: \(path)")
            print("Would you like to try again? (y/n):")
            let retry = readLine()?.lowercased() ?? "n"
            if retry != "y" {
                fatalError("Could not load cluster status file")
            }
        }
    }
}

@main
struct App {
    static func main() {
        let fileContent = loadClusterStatus()
        let cluster = parseClusterStatus(fileContent: fileContent)
        let menu = InteractiveMenu(cluster: cluster, serviceRequirements: loadServiceRequirements())
        menu.showMainMenu()
    }
}
