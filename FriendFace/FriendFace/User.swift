//
//  User.swift
//  FriendFace
//
//  Created by Michael Peralta on 5/16/26.
//

import Foundation
import SwiftData

@Model
class User {
    @Attribute(.unique) var id: String
    var name: String
    var isActive: Bool
    var age: Int
    var company: String
    var email: String
    var registered: Date
    @Relationship(deleteRule: .cascade) var friends: [Friend]
    
    init(id: String, name: String, isActive: Bool, age: Int, company: String, email: String, registered: Date, friends: [Friend]) {
        self.id = id
        self.name = name
        self.isActive = isActive
        self.age = age
        self.company = company
        self.email = email
        self.registered = registered
        self.friends = friends
    }
}

struct UserDTO: Codable {
    let id: String
    let name: String
    let isActive: Bool
    let age: Int
    let company: String
    let email: String
    let registered: Date
    let friends: [FriendDTO]
}
