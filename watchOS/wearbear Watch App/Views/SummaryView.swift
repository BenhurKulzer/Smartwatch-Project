import SwiftUI

struct SummaryView: View {
    let robotCount: Int
    let locationId: Int
    let locationName: String
    
    @StateObject private var viewModel = SummaryViewModel()
    @State private var progress: Double = 0.0
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 20) {
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(CircularProgressViewStyle())
                .frame(width: 50, height: 50)
                .padding(.top, 20)
            
            Text("Sending \(robotCount) \(robotCount == 1 ? "Bear" : "Bears") to \(locationName)")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            NavigationLink(destination: ItemListView()) {
                Text("Close").foregroundColor(.white)
            }
        }
        .onAppear {
            startProgress()
            viewModel.sendRobot(locationId: locationId, robotCount: robotCount)
        }
        .navigationTitle(locationName)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func startProgress() {
        progress = 0.0
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.progress < 1.0 {
                self.progress += 0.02
            } else {
                timer.invalidate()
            }
        }
    }
}
