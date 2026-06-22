//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Michael Peralta on 5/31/26.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
        .modelContainer(for: Prospect.self)
    }
}
