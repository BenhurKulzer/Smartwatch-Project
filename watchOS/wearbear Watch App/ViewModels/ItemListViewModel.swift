//
//  ItemListViewModel.swift
//  wearbear
//
//  Created by Benhur on 10/10/24.
//

import Foundation
import Combine

class ItemListViewModel: ObservableObject {
    @Published var items: [ItemModel] = []
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadItems()
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
}
