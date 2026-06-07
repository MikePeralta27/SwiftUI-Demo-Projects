//
//  DetailView.swift
//  FaceRecall
//
//  Created by Michael Peralta on 6/6/26.
//
import MapKit
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
            if let coordinate = photo.location {
                let region = MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.3,
                        longitudeDelta: 0.3
                    )
                )
                let cameraPosition = MapCameraPosition.region(region)
                
                Map(initialPosition: cameraPosition) {

                    Annotation("Saved near here", coordinate: coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundStyle(.red)
                    }
                }
                .frame(height: 250)
                .clipShape(.rect(cornerRadius: 12))
            } else {
                ContentUnavailableView(
                    "No location saved",
                    systemImage: "mappin.slash",
                    description: Text(
                        "Location wasn’t available when this contact was added."
                    )
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

#Preview("With location") {
    DetailView(
        photo: NamedPhoto(
            name: "Alex",
            photoData: Data(),
            location: CLLocationCoordinate2D(
                latitude: 37.78,
                longitude: -122.41
            )
        )
    )
}
