import Foundation
import Combine

class ItemListViewModel: ObservableObject {
    @Published var items: [ItemModel] = []
    @Published var isLoading: Bool = false
    @Published var queueRequests: Set<Int> = []
    @Published var robotCounts: [Int: Int] = [:]
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadItems()
        loadQueueRequests()
    }
    
    func refreshData() {
        loadItems()
        loadQueueRequests()
    }

    func loadItems() {
        isLoading = true

        guard let url = URL(string: "http://localhost:3000/api/locations") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [ItemModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] items in
                self?.items = items
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func loadQueueRequests() {
        guard let url = URL(string: "http://localhost:3000/api/queue") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [QueueItem].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching queue requests: \(error)")
                }
            }, receiveValue: { [weak self] queueItems in
                self?.queueRequests = Set(queueItems.map { $0.locationId })
                self?.calculateRobotCounts(from: queueItems)
            })
            .store(in: &cancellables)
    }

    private func calculateRobotCounts(from queueItems: [QueueItem]) {
        robotCounts = [:]

        for item in queueItems {
            robotCounts[item.locationId, default: 0] += 1
        }
    }

    func cancelRobotRequest(locationId: Int) {
        guard let url = URL(string: "http://localhost:3000/api/robots/cancel") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(["locationId": locationId])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { [weak self] _, response, error in
            if let error = error {
                print("Error cancelling robot request: \(error)")
                return
            }

            DispatchQueue.main.async {
                self?.loadQueueRequests()
            }
        }.resume()
    }
}
