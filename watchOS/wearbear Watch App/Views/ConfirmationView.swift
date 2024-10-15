//
//  ConfirmationView.swift
//  wearbear
//
//  Created by Benhur on 11/10/24.
//

import SwiftUI

struct ConfirmationView: View {
    let robot: RobotModel
    let locationName: String
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Confirm send \(robot.name) to \(locationName)?")
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 10) {
                Button(action: onCancel) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 50, height: 50)
                }
                .background(Color.red)
                .cornerRadius(25)

                Button(action: onConfirm) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 50, height: 50)
                }
                .background(Color.green)
                .cornerRadius(25)
            }
            .padding(.horizontal, 20)
        }
        .padding()
        .background(Color(.black))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
