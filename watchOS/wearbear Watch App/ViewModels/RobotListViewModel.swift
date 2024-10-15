//
//  RobotListViewModel.swift
//  wearbear
//
//  Created by Benhur on 10/10/24.
//

import Foundation
import Combine

class RobotListViewModel: ObservableObject {
    @Published var robots: [RobotModel] = []
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func loadRobots() {
        isLoading = true
        
        guard let url = URL(string: "http://localhost:3000/api/robots") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [RobotModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] robots in
                self?.robots = robots
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
}
