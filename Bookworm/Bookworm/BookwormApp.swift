//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Michael Peralta on 5/8/26.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
