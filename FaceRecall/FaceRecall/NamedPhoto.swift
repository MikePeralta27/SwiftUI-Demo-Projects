//
//  NamedPhoto.swift
//  FaceRecall
//
//  Created by Michael Peralta on 6/6/26.
//
import Foundation
import SwiftData

@Model
class NamedPhoto {
    var id: UUID
    var name: String
    @Attribute(.externalStorage) var photoData: Data
    
    init(name: String, photoData: Data) {
        self.id = UUID()
        self.name = name
        self.photoData = photoData
    }
    
}
