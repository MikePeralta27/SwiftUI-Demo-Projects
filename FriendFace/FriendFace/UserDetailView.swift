//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Michael Peralta on 5/18/26.
//

import SwiftUI

struct UserDetailView: View {

    let user: User

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("User Information")) {
                    Text(user.name)
                    Text("Age: \(user.age, specifier: "%d")")
                    Text("Email: \(user.email)")
                    Text("Company: \(user.company)")
                    Text(
                        "Registered: \(user.registered.formatted(date: .long, time: .shortened))"
                    )
                    
                    if user.isActive {
                        Text("Status: Active")
                    } else {
                        Text("Status: Inactive")
                    }
                }
                
                Section("Friends") {
                    ForEach(user.friends){ friend in
                        Text(friend.name)
                    }
                }
            }
            .navigationTitle(user.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    // Replace with a realistic mock matching your User model
    let sampleUser = User(
        id: "00000000-0000-0000-0000-000000000000",
        name: "Preview User",
        isActive: true,
        age: 30,
        company: "Preview Co",
        email: "preview@example.com",
        registered: .now,
        friends: []
    )
    UserDetailView(user: sampleUser)
}
