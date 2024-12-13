struct Node: NodeProtocol {
    var id: Int
    var cpu: Int
    var ram: Int
    var pods: [PodProtocol]
}
