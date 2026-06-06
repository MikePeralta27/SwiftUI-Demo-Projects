//
//  ContentView.swift
//  FaceRecall
//
//  Created by Michael Peralta on 6/4/26.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var processedImage: Image?
    @State private var selectedItem: PhotosPickerItem?
    @State private var pendingPhotoData: Data?
    @State private var nameInput = ""
    @State private var showingNameAlert = false

    @Query(sort: \NamedPhoto.name) private var photos: [NamedPhoto]

    var body: some View {
        NavigationStack {
            List {
                ForEach(photos) { photo in
                    NavigationLink(value: photo) {
                        HStack {
                            if let uiImage = UIImage(data: photo.photoData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 44, height: 44)
                                    .clipShape(.rect(cornerRadius: 8))
                            }

                            Text(photo.name)
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        modelContext.delete(photos[index])
                    }
                }
            }
            .navigationDestination(
                for: NamedPhoto.self,
                destination: { photo in
                    DetailView(photo: photo)
                }
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(selection: $selectedItem) {
                        Label("Select an image", systemImage: "plus")

                    }

                }  // ToolbarItem
            }  // Toolbar
            .navigationTitle("Face Recall")
            .onChange(of: selectedItem, initial: false) {
                Task {
                    guard let newValue = selectedItem else { return }
                    guard
                        let data = try await newValue.loadTransferable(
                            type: Data.self
                        )
                    else { return }

                    pendingPhotoData = data
                    nameInput = ""
                    showingNameAlert = true
                    selectedItem = nil

                }  // Task
            }  // on Chages
        }  // navigationStack
        .alert("Name this person", isPresented: $showingNameAlert) {
            TextField("Enter Name", text: $nameInput)

            Button("Save") {
                guard let data = pendingPhotoData else { return }
                let trimmed = nameInput.trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
                guard trimmed.isEmpty == false else { return }

                let photo = NamedPhoto(name: trimmed, photoData: data)
                modelContext.insert(photo)
                try? modelContext.save()

                pendingPhotoData = nil
                nameInput = ""
            }

            Button("Cancel", role: .cancel) {
                pendingPhotoData = nil
                nameInput = ""
            }
        } message: {
            Text("Who is in this photo?")
        }  // Alert close
    }
}

#Preview {
    ContentView()
        .modelContainer(for: NamedPhoto.self, inMemory: true)  // doesn't persist
}
