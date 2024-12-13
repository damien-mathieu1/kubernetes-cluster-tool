enum ContainerStatus: String {
    case running = "running"
    case stopped = "stopped"
    case crashed = "crashed"
}

protocol ContainerProtocol {
    var name: String { get }
    var status: ContainerStatus { get set }
    var cpu: Int { get set }
    var ram: Int { get set }
}
