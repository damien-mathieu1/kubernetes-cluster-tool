protocol PodProtocol {
    var id: Int { get }
    var containers: [ContainerProtocol] { get set }
}
