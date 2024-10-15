//
//  ItemListView.swift
//  wearbear
//
//  Created by Benhur on 10/10/24.
//

import SwiftUI

struct ItemListView: View {
    @ObservedObject var viewModel = ItemListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Carregando locais...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    List(viewModel.items) { item in
                        NavigationLink(destination: RobotListView(locationName: item.name)) {
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.white)
                                    .padding(.trailing, 8)
                                
                                Text(item.name)
                                    .padding()
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .navigationTitle("Locations")
                }
            }
        }
    }
}
