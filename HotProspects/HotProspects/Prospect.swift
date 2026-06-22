import Foundation
//
//  Prospect.swift
//  HotProspects
//
//  Created by Michael Peralta on 6/11/26.
//
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var addedDate: Date

    init(
        name: String,
        emailAddress: String,
        isContacted: Bool,
        addedDate: Date = .now
    ) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.addedDate = addedDate

    }
}
