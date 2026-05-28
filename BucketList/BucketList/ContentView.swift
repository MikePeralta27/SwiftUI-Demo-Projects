//
//  ContentView.swift
//  BucketList
//
//  Created by Michael Peralta on 5/24/26.
//
import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )

    @State private var viewModel = ViewModel()

    var body: some View {
        Group {
            if viewModel.isUnlocked {
                NavigationStack {
                    MapReader { proxy in
                        Map(initialPosition: startPosition) {
                            ForEach(viewModel.locations) { location in
                                Annotation(
                                    location.name,
                                    coordinate: location.coordinate
                                ) {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .foregroundStyle(.red)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(.circle)
                                        .onTapGesture(count: 2) {
                                            viewModel.selectedPlace = location
                                        }
                                }
                            }
                        }
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local)
                            {
                                viewModel.addLocation(at: coordinate)

                            }
                        }
                        .sheet(item: $viewModel.selectedPlace) {
                            (place: Location) in
                            EditView(location: place) {
                                viewModel.update(location: $0)
                            }
                        }
                        .mapStyle(viewModel.selectedMapStyle)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Picker("Map Style", selection: $viewModel.mapStyle)
                                {
                                    ForEach(ViewModel.MapStyleChoice.allCases) {
                                        style in
                                        Text(style.displayName).tag(style)

                                    }
                                }
                                .pickerStyle(.segmented)

                            }
                        }
                        
                       
                    }
                }
                
            }
            else {
                // Button to handle auth
                Button("Unlock places") {
                    viewModel.authenticate()

                }
                .padding()
                .background(.blue)
                .foregroundStyle(Color.white)
                .clipShape(Capsule())
            }
        }
        .alert(
            "Error",
            isPresented: .init(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            ),
            actions: {
                Button("OK") { viewModel.errorMessage = nil }
            },
            message: {
                Text(viewModel.errorMessage ?? "")
            }
        )

    }
}

#Preview {
    ContentView()
}
