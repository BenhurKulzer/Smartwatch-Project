import Foundation
import Combine

class QueueViewModel: ObservableObject {
    @Published var hasRequests: [String: Bool] = [:]
    private var cancellables = Set<AnyCancellable>()
    private var timer: AnyCancellable?
    
    func startQueuePolling(locations: [Location]) {
        timer = Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.checkAllQueues(locations: locations)
            }
    }
    
    func checkAllQueues(locations: [Location]) {
        // Limpa os estados anteriores
        hasRequests.removeAll()
        
        // Executa a verificação para cada localização
        for location in locations {
            checkQueue(for: location.id)
        }
    }

    func checkQueue(for locationId: String) {
        guard let url = URL(string: "http://localhost:3000/api/queue/\(locationId)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: QueueResponse.self, decoder: JSONDecoder())
            .replaceError(with: QueueResponse(requests: [])) // Handle errors gracefully
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                self?.hasRequests[locationId] = !response.requests.isEmpty
            }
            .store(in: &cancellables)
    }

    deinit {
        timer?.cancel() // Cancela o timer quando a ViewModel é desalocada
    }
}
