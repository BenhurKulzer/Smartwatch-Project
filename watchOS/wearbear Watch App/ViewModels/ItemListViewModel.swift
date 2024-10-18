import Foundation
import Combine

class ItemListViewModel: ObservableObject {
    @Published var items: [ItemModel] = []
    @Published var isLoading: Bool = false
    @Published var queueRequests: Set<Int> = []
    
    private var cancellables = Set<AnyCancellable>()

    init() {
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
            })
            .store(in: &cancellables)
    }

    func deleteItem(_ item: ItemModel) {
        print("Printing... \(item.id)")
    }
}
