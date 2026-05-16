//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Michael Peralta on 5/13/26.
//
import SwiftData
import SwiftUI

struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var users: [User]
    var body: some View {
        List(users) { user in
            HStack {
                Text(user.name)
                
                Spacer()
                
                Text(String(user.unwrappedJobs.count))
                    .fontWeight(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .clipShape(Capsule())
                    
            }
        }
        .onAppear {
            addSample()
        }
    }
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: \User.name)
    }
    
    func addSample() {
        let user1 = User(name: "Michael",city: "Santo domingo", joinDate: .now)
        let job1 = Job(name: "Piper chapman", priority: 4)
        let job2 = Job(name: "Coder", priority: 1)
        
        modelContext.insert(user1)
        
        user1.jobs?.append(job1)
        user1.jobs?.append(job2)
        
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
