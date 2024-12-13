protocol NodeProtocol {
    var id: Int { get }
    var cpu: Int { get }
    var ram: Int { get }
    var pods: [PodProtocol] { get set }
}
