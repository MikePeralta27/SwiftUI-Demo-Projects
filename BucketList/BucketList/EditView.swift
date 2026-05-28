//
//  editView.swift
//  BucketList
//
//  Created by Michael Peralta on 5/27/26.
//

import SwiftUI


struct EditView: View {
    @Environment(\.dismiss) var dismiss

    @State private var viewModel: ViewModel
    let onSave: (Location) -> Void


    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        _viewModel = State(initialValue: ViewModel(location: location))
        
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        ProgressView()
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                                + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Failed to load")
                            .italic()
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    onSave(newLocation)
                    dismiss()

                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
        
        

    }

   

   
}

#Preview {
    EditView(location: .example) { _ in }
}
