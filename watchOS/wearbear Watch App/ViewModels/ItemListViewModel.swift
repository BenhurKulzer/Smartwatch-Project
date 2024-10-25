import Foundation
import Combine
import GRPC
import NIO
import SwiftProtobuf

class ItemListViewModel: ObservableObject {
    @Published var items: [ItemModel] = []
    @Published var isLoading: Bool = false
    @Published var queueRequests: Set<String> = []
    @Published var robotCounts: [String: Int] = [:]

    private var cancellables = Set<AnyCancellable>()
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    private var client: Robotservice_RobotServiceNIOClient?  // Atualizado para Robotservice_RobotServiceNIOClient

    init() {
        setupClient()
        loadItems()
    }

    deinit {
        try? group.syncShutdownGracefully()
    }

    private func setupClient() {
        let channel = ClientConnection.insecure(group: group)
            .connect(host: "localhost", port: 50051)
        client = Robotservice_RobotServiceNIOClient(channel: channel)  // Atualizado para NIOClient
    }

    func refreshData() {
        loadItems()
    }

    func loadItems() {
        isLoading = true
        var request = Robotservice_Empty()  // Usar o tipo gerado para o request

        client?.getLocations(request).response
            .whenComplete { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self?.items = response.locations.compactMap {
                            if let intId = Int($0.id) {
                                return ItemModel(id: intId, name: $0.name)
                            } else {
                                print("Failed to convert id '\($0.id)' to Int")
                                return nil
                            }
                        }
                        self?.isLoading = false
                    case .failure(let error):
                        print("Failed to load locations: \(error)")
                        self?.isLoading = false
                    }
                }
            }
    }


    func cancelRobotRequest(locationId: String) {
        var request = Robotservice_CancelRequest()
        request.locationID = locationId

        client?.cancelCall(request).response
            .whenComplete { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        print("Cancelled request: \(response.message)")
                    case .failure(let error):
                        print("Failed to cancel robot request: \(error)")
                    }
                }
            }
    }
}
