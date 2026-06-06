//
//  DetailView.swift
//  FaceRecall
//
//  Created by Michael Peralta on 6/6/26.
//

import SwiftUI

struct DetailView: View {

    var photo: NamedPhoto

    var body: some View {
        Group {
            if let uiImage = UIImage(data: photo.photoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ContentUnavailableView(
                    "Image not found",
                    systemImage: "photo",
                    description: Text(photo.name)
                )
            }
        }
        .navigationTitle(photo.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(photo: NamedPhoto(name: "example", photoData: .init()))
}
