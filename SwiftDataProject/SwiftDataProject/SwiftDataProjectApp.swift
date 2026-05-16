//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Michael Peralta on 5/11/26.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
