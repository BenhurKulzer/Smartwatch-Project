//
//  SummaryViewModel.swift
//  wearbear
//
//  Created by Benhur on 17/10/24.
//


import Foundation
import Combine

class SummaryViewModel: ObservableObject {
    @Published var progress: Double = 0.0
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func sendRobot(locationId: Int, robotCount: Int) {
        guard let url = URL(string: "http://localhost:3000/api//robots/call") else { return }
        
        let request = RobotRequest(locationId: locationId, robotCount: robotCount)
        
        guard let requestData = try? JSONEncoder().encode(request) else {
            self.isError = true
            self.errorMessage = "Failed to encode request data."
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = requestData
        
        isLoading = true
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.isError = true
                    self.errorMessage = "Failed to send robot: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data, let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    self.isError = true
                    self.errorMessage = "Server error. Please try again."
                    return
                }
                
                // Processar a resposta se necessário
                print("Robot sent successfully: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }.resume()
    }
}
