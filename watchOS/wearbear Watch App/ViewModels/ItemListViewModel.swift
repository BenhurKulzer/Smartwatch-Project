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

    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    private var client: Robotservice_RobotServiceNIOClient?
    
    init() {
        setupClient()
        refreshData()
    }

    deinit {
        try? group.syncShutdownGracefully()
    }

    private func setupClient() {
        let channel = ClientConnection.insecure(group: group)
            .connect(host: "localhost", port: 50051)
        client = Robotservice_RobotServiceNIOClient(channel: channel)
    }

    func refreshData() {
        loadItems()
        loadQueueRequests()
    }

    func loadItems() {
        isLoading = true
        var request = Robotservice_Empty()
        
        client?.getLocations(request).response.whenComplete { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.items = response.locations.compactMap {
                        guard let intId = Int($0.id) else { return nil }
                        return ItemModel(id: intId, name: $0.name)
                    }
                    self?.isLoading = false
                case .failure(let error):
                    print("Failed to load locations: \(error)")
                    self?.isLoading = false
                }
            }
        }
    }

    func loadQueueRequests() {
        let request = Robotservice_Empty()
        
        client?.getQueue(request).response
            .whenComplete { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self?.updateRobotCounts(from: response.queues)
                    case .failure(let error):
                        print("Failed to load queue requests: \(error)")
                    }
                }
            }
    }

    private func updateRobotCounts(from queues: [Robotservice_Queue]) {
        robotCounts = [:]
        
        for queue in queues {
            let locationId = queue.locationID
            robotCounts[locationId, default: 0] += 1
        }
    }

    func cancelRobotRequest(locationId: String) {
        var request = Robotservice_CancelRequest()
        request.locationID = locationId

        client?.cancelCall(request).response.whenComplete { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("Cancelled request: \(response.message)")
                    self.queueRequests.remove(locationId)
                    self.robotCounts[locationId] = 0
                case .failure(let error):
                    print("Failed to cancel robot request: \(error)")
                }
            }
        }
    }
}
