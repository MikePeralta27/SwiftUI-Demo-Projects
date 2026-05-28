//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Michael Peralta on 5/27/26.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit
import SwiftUI

extension ContentView {
    @Observable
    class ViewModel {

        private(set) var locations: [Location]
        var selectedPlace: Location?
        var isUnlocked: Bool = false

        var errorMessage: String?
        var showingAlert: Bool { errorMessage != nil }

        var selectedMapStyle: MapStyle {
            mapStyle.mapStyle
        }

        enum MapStyleChoice: String, CaseIterable, Identifiable {
            case standard, imagery, hybrid

            var id: String { rawValue }
            var displayName: String {
                switch self {
                case .standard: "Standard"
                case .imagery: "Imagery"
                case .hybrid: "Hybrid"
                }
            }
            var mapStyle: MapStyle {
                switch self {
                case .standard: .standard
                case .imagery: .imagery
                case .hybrid: .hybrid
                }
            }
        }
        var mapStyle: MapStyleChoice = .standard

        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode(
                    [Location].self,
                    from: data
                )
            } catch {
                locations = []
            }
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(
                    to: savePath,
                    options: [.atomic, .completeFileProtection]
                )
            } catch {
                print("Unable to save data.")
            }
        }

        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(
                id: UUID(),
                name: "New location",
                description: "",
                latitude: point.latitude,
                longitude: point.longitude
            )
            locations.append(newLocation)
            save()
        }

        func update(location: Location) {
            guard let selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }

        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                error: &error
            ) {
                let reason = "Please authenticate yourself to unlock places."

                context.evaluatePolicy(
                    .deviceOwnerAuthenticationWithBiometrics,
                    localizedReason: reason
                ) { success, authenticateError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.errorMessage =
                            authenticateError?.localizedDescription
                    }

                }
            } else {
                self.errorMessage = error?.localizedDescription
            }
        }
    }
}
