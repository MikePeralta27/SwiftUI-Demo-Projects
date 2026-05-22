//
//  Friend.swift
//  FriendFace
//
//  Created by Michael Peralta on 5/16/26.
//

import Foundation
import SwiftData

@Model
class Friend {
    var id: String 
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

struct FriendDTO: Codable {
    let id: String
    let name: String
}
