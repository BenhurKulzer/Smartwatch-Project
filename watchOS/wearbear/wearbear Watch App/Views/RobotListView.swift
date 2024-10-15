//
//  RobotListView.swift
//  wearbear
//
//  Created by Benhur on 10/10/24.
//

import SwiftUI

struct RobotListView: View {
    let locationName: String
    @ObservedObject var viewModel = RobotListViewModel()
    @State private var selectedRobot: RobotModel? = nil
    @State private var showConfirmation: Bool = false
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                List(viewModel.robots) { robot in
                    Button(action: {
                        selectedRobot = robot
                        showConfirmation = true
                    }) {
                        HStack {
                            Text(robot.name)
                                .font(.headline)
                            
                            Spacer()
                            
                            Text("\(robot.battery)%")
                                .font(.subheadline)

                            Circle()
                                .fill(circleColor(for: robot.status))
                                .frame(width: 12, height: 12)
                                .padding(.leading, 8)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .navigationTitle(locationName)
                .sheet(isPresented: $showConfirmation) {
                    if let robot = selectedRobot {
                        ConfirmationView(robot: robot, locationName: locationName, onConfirm: {
                            showConfirmation = false
                        }, onCancel: {
                            showConfirmation = false
                        })
                    } else {
                        Text("Error on handle robot data, try again")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadRobots()
        }
    }
    
    private func circleColor(for status: String) -> Color {
        switch status {
            case "Running":
                return .green
            case "Idle":
                return .blue
            case "Offline":
                return .gray
            case "Charging":
                return .yellow

            default:
                return .gray
        }
    }
}
