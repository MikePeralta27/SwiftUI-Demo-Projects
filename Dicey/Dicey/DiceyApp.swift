//
//  DiceyApp.swift
//  Dicey
//
//  Created by Michael Peralta on 6/25/26.
//

import SwiftData
import SwiftUI

// 2. CONTAINER — modelContainer creates DB and injects modelContext
@main
struct DiceyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: RollRecord.self)
    }
}
