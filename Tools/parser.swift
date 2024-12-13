/// Parses cluster status from a file content string
/// - Parameter fileContent: The content of the cluster status file
/// - Returns: A Cluster object representing the parsed status
func parseClusterStatus(fileContent: String) -> Cluster {
    var nodes = [Node]()
    var currentNode: Node?
    var currentPod: Pod?

    for line in fileContent.split(separator: "\n") {
        let trimmedLine = line.trimmingCharacters(in: .whitespaces)
        if trimmedLine.hasPrefix("Node:") {
            if let node = currentNode {
                nodes.append(node)
            }
            currentNode = parseNode(line: trimmedLine)
        } else if trimmedLine.hasPrefix("Ressources:") {
            if let node = currentNode {
                let (cpu, ram) = parseResources(line: trimmedLine)
                currentNode = Node(id: node.id, cpu: cpu, ram: ram, pods: node.pods)
            }
        } else if trimmedLine.hasPrefix("Pod:") {
            if let pod = currentPod, var node = currentNode {
                node.pods.append(pod)
                currentNode = node
            }
            currentPod = parsePod(line: trimmedLine)
        } else if trimmedLine.hasPrefix("Container:") {
            if let pod = currentPod {
                let container = parseContainer(line: trimmedLine)
                currentPod = Pod(id: pod.id, containers: pod.containers + [container])
            }
        }
    }

    if let pod = currentPod, var node = currentNode {
        node.pods.append(pod)
        currentNode = node
    }

    if let node = currentNode {
        nodes.append(node)
    }

    return Cluster(nodes: nodes)
}

/// Parses a node definition line
/// - Parameter line: The line containing node information
/// - Returns: A Node object with the parsed ID
func parseNode(line: String) -> Node {
    let nodeId = extractIntValue(from: line[...], separator: ":")
    return Node(id: nodeId, cpu: 0, ram: 0, pods: [])
}

/// Parses resource information from a line
/// - Parameter line: The line containing resource information
/// - Returns: A tuple containing CPU and RAM values
func parseResources(line: String) -> (Int, Int) {
    let resources = extractValues(from: line, prefix: "Ressources: ", separator: "|")
    let cpu = extractIntValue(from: resources[0], separator: ":")
    let ram = extractIntValue(from: resources[1], separator: ":")
    return (cpu, ram)
}

/// Parses a pod definition line
/// - Parameter line: The line containing pod information
/// - Returns: A Pod object with the parsed ID
func parsePod(line: String) -> Pod {
    let podId = extractIntValue(from: line[...], separator: ":")
    return Pod(id: podId, containers: [])
}

/// Parses a container definition line
/// - Parameter line: The line containing container information
/// - Returns: A Container object with the parsed properties
func parseContainer(line: String) -> Container {
    let containerDetails = extractValues(from: line, prefix: "Container: ", separator: "|")
    let containerName = String(containerDetails[0].split(separator: " ")[0])
    let containerStatus = ContainerStatus(
        rawValue: extractStringValue(from: containerDetails[1], separator: ":"))!
    let containerCpu = extractIntValue(from: containerDetails[2], separator: ":")
    let containerRam = extractIntValue(from: containerDetails[3], separator: ":")
    return Container(
        name: containerName, status: containerStatus, cpu: containerCpu, ram: containerRam)
}
