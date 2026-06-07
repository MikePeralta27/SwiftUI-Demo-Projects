//
//  NamedPhoto.swift
//  FaceRecall
//
//  Created by Michael Peralta on 6/6/26.
//
import Foundation
import SwiftData
import CoreLocation

@Model
class NamedPhoto {
    var id: UUID
    var name: String
    var latitude: Double?
    var longitude: Double?
    var location: CLLocationCoordinate2D? {
        get {
            guard let lat = latitude, let lon = longitude else { return nil }
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        set {
            if let newValue = newValue {
                latitude = newValue.latitude
                longitude = newValue.longitude
            } else {
                latitude = nil
                longitude = nil
            }
        }
    }
    @Attribute(.externalStorage) var photoData: Data
    
    init(name: String, photoData: Data, location: CLLocationCoordinate2D? = nil) {
        self.id = UUID()
        self.name = name
        self.photoData = photoData
        self.location = location
    }
    
}
