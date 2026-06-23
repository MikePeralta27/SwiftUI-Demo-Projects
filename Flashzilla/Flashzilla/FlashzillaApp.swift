//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Michael Peralta on 6/19/26.
//

import SwiftData
import SwiftUI

@main
struct FlashzillaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Card.self)
    }
}
