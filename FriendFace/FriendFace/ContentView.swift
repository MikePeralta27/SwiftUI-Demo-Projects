//
//  ContentView.swift
//  FriendFace
//
//  Created by Michael Peralta on 5/16/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext

    @Query(sort: [
        SortDescriptor(\User.name, order: .forward),
        SortDescriptor(\User.age, order: .forward),
    ]) private var users: [User]

   
    var body: some View {
        NavigationStack {
            List {
                ForEach(users, id: \.id) { user in

                    NavigationLink(destination: UserDetailView(user: user)) {
                        Text(user.name)
                    }
                }
            }
            .navigationTitle(Text("FriendFace"))
            .task {
                if users.isEmpty {
                    print("Task runned")
                    await fetchUsers()
                }
            }
        }
    }

    func fetchUsers() async {

        do {
            guard
                let url = URL(
                    string:
                        "https://www.hackingwithswift.com/samples/friendface.json"
                )
            else { return }

            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let dtos = try decoder.decode([UserDTO].self, from: data)
            for dto in dtos {
                let friendModels = dto.friends.map {
                    Friend(id: $0.id, name: $0.name)
                }
                let user = User(
                    id: dto.id,
                    name: dto.name,
                    isActive: dto.isActive,
                    age: dto.age,
                    company: dto.company,
                    email: dto.email,
                    registered: dto.registered,
                    friends: friendModels
                )
                modelContext.insert(user)
            }

        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
