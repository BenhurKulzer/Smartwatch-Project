//
//  RobotListView.swift
//  wearbear
//
//  Created by Benhur on 10/10/24.
//

import SwiftUI

struct RobotListView: View {
    let locationName: String
    
    @State private var robotCount: Int = 1
    @State private var showConfirmation: Bool = false
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Text("How many bears do you need?")
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20)
            
            Stepper("\(robotCount)", value: $robotCount, in: 1...5)
                .padding(.top, 5)
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(width: 50, height: 50)
                }
                .background(Color.red)
                .cornerRadius(24)
                
                Spacer(minLength: 24)
                
                NavigationLink(destination: SummaryView(robotCount: robotCount, locationName: locationName)) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(width: 50, height: 50)
                }
                .background(Color.green)
                .cornerRadius(24)
            }
            .padding(.top, 5)
        }
        .navigationTitle(locationName)
        .padding()
    }
}
