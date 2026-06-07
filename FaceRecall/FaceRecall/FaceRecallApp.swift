//
//  FaceRecallApp.swift
//  FaceRecall
//
//  Created by Michael Peralta on 6/4/26.
//

import SwiftUI
import SwiftData

@main
struct FaceRecallApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: NamedPhoto.self)
    }
}
