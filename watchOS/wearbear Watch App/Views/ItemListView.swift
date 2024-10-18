import SwiftUI

struct ItemListView: View {
    @ObservedObject var viewModel = ItemListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    List {
                        ForEach(viewModel.items) { item in
                            NavigationLink(destination: RobotListView(locationName: item.name, locationId: item.id)) {
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
                                Button {
                                    viewModel.deleteItem(item)
                                } label: {
                                    Label("Delete", systemImage: "xmark")
                                }
                                .tint(.red)
                            }
                        }
                    }
                    .navigationTitle("Locations")
                }
            }
        }
    }
}
