import SwiftUI

struct ItemListView: View {
    @ObservedObject var viewModel = ItemListViewModel()
    @State private var path = NavigationPath()
    @State private var showingConfirmation = false
    @State private var selectedItemId: Int? = nil
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    List {
                        ForEach(viewModel.items) { item in
                            NavigationLink(destination: RobotListView(locationName: item.name, locationId: item.id, path: $path)) {
                                HStack {
                                    Image(systemName: "location.fill")
                                        .foregroundColor(.white)
                                        .padding(.trailing, 8)
                                    
                                    Text(item.name)
                                        .padding()
                                        .cornerRadius(8)
                                    
                                    Spacer()

                                    if viewModel.queueRequests.contains(item.id) {
                                        let robotCount = viewModel.robotCounts[item.id] ?? 0
                                        LoadingGauge(number: robotCount)
                                    }
                                }
                            }
                            .swipeActions {
                                if viewModel.queueRequests.contains(item.id) { // Only show if in queueRequests
                                    Button {
                                        selectedItemId = item.id
                                        showingConfirmation = true // Show confirmation action sheet
                                    } label: {
                                        Label("Cancel", systemImage: "xmark")
                                    }
                                    .tint(.red)
                                }
                            }
                        }
                    }
                    .navigationTitle("Locations")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitleDisplayMode(.large)
                    .actionSheet(isPresented: $showingConfirmation) {
                        ActionSheet(title: Text(""),
                                    message: Text("Do you want to cancel this robot request?"),
                                    buttons: [
                                        .destructive(Text("Cancel Request")) {
                                            if let id = selectedItemId {
                                                viewModel.cancelRobotRequest(locationId: id)
                                            }
                                            showingConfirmation = false
                                        },
                                        .cancel {
                                            showingConfirmation = false
                                        }
                                    ])
                    }
                }
            }
        }
    }
}
