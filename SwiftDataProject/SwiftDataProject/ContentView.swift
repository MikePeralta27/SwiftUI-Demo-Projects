//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Michael Peralta on 5/11/26.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate),
    ]

    var body: some View {
        NavigationStack {
            UsersView(
                minimumJoinDate: showingUpcomingOnly ? .now : .distantPast,
                sortOrder: sortOrder
            )
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
            }
            .toolbar {
                Button("Add User", systemImage: "plus") {

                    try? modelContext.delete(model: User.self)

                    let first = User(
                        name: "Ed Sheeran",
                        city: "London",
                        joinDate: .now.addingTimeInterval(86400 * -10)
                    )
                    let second = User(
                        name: "Taylor Swift",
                        city: "London",
                        joinDate: .now.addingTimeInterval(86400 * -5)
                    )
                    let third = User(
                        name: "Shakira",
                        city: "London",
                        joinDate: .now.addingTimeInterval(86400 * 5)
                    )
                    let fourth = User(
                        name: "Drake",
                        city: "London",
                        joinDate: .now.addingTimeInterval(86400 * 10)
                    )

                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                    //                    try? modelContext.save()
                }

                Button(
                    showingUpcomingOnly ? "Show Everyone" : "Showing upcoming"
                ) {
                    showingUpcomingOnly.toggle()
                }

                Menu("Sort", systemImage: "arrow.up.arrow.down"){
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate),
                            ])
                        
                        Text("Sort by join date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name),
                            ])
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: User.self,
            configurations: config
        )
        let user = User(name: "Taylor Swfit", city: "Nasville", joinDate: .now)

        return ContentView()
            .modelContainer(container)

    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }

}
