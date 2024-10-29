import SwiftUI

struct ItemListView: View {
    @ObservedObject var viewModel = ItemListViewModel()
    @State private var path = NavigationPath()
    @State private var showingConfirmation = false
    @State private var selectedItemId: String? = nil

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    List {
                        ForEach(viewModel.items, id: \.id) { item in
                            NavigationLink(destination: RobotListView(locationName: item.name, locationId: item.id, path: $path)) {
                                HStack {
                                    Image(systemName: "location.fill")
                                        .foregroundColor(.white)
                                        .padding(.trailing, 8)

                                    Text(item.name)
                                        .padding()
                                        .cornerRadius(8)

                                    Spacer()

                                    if let robotCount = viewModel.robotCounts[String(item.id)], robotCount > 0 {
                                        LoadingGauge(number: robotCount)
                                    }
                                }
                            }
                            .swipeActions {
                                if let robotCount = viewModel.robotCounts[String(item.id)], robotCount > 0 {
                                    Button {
                                        selectedItemId = String(item.id)
                                        showingConfirmation = true
                                    } label: {
                                        Label("Cancel", systemImage: "xmark")
                                    }
                                    .tint(.red)
                                }
                            }
                        }
                    }
                    .refreshable {
                        viewModel.refreshData()
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
            .onAppear {
                viewModel.refreshData()
            }
        }
    }
}
