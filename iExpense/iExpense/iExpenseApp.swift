//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Michael Peralta on 4/13/26.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
