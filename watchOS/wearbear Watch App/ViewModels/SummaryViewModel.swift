import Foundation
import Combine
import GRPC
import NIO
import SwiftProtobuf

class SummaryViewModel: ObservableObject {
    @Published var progress: Double = 0.0
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""

    private var client: Robotservice_RobotServiceNIOClient?
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

    init() {
        setupClient()
    }

    deinit {
        try? group.syncShutdownGracefully()
    }

    private func setupClient() {
        let channel = ClientConnection.insecure(group: group)
            .connect(host: "localhost", port: 50051)
        client = Robotservice_RobotServiceNIOClient(channel: channel)
        print("gRPC client initialized and connected to server.")
    }

    func sendRobot(locationId: Int, robotCount: Int) {
        var request = Robotservice_CallRequest()
        request.locationID = String(locationId)  // Convert locationId to String if needed
        
        print("Preparing to send robot with the following details:")
        print("Location ID: \(locationId)")
        print("Robot Count: \(robotCount)")
        print("Request Object: \(request)")
        
        isLoading = true
        print("Setting isLoading to true.")
        
        client?.callRobot(request).response.whenComplete { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                print("Request completed. Setting isLoading to false.")

                switch result {
                case .success(let response):
                    print("Robot sent successfully. Server response: \(response.message)")
                case .failure(let error):
                    self.isError = true
                    self.errorMessage = "Failed to send robot: \(error.localizedDescription)"
                    print("Error sending robot: \(error.localizedDescription)")
                }
                
                print("Current State after request completion:")
                print("isError: \(self.isError)")
                print("errorMessage: \(self.errorMessage)")
            }
        }
    }
}
