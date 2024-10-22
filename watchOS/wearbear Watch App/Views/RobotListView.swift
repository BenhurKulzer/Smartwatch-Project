import SwiftUI

struct RobotListView: View {
    let locationName: String
    let locationId: Int
    
    @State private var robotCount: Int = 1
    @State private var showConfirmation: Bool = false
    @Binding var path: NavigationPath
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Text("How many bears do you need?")
                    .font(.headline)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20)
            
            Stepper("\(robotCount)", value: $robotCount, in: 1...1)
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

                NavigationLink(destination: SummaryView(robotCount: robotCount, locationId: locationId, locationName: locationName, path: $path)) {
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
