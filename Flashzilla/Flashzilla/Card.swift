//
//  Card.swift
//  Flashzilla
//
//  Created by Michael Peralta on 6/20/26.
//

import Foundation
import SwiftData

@Model
class Card {
    var id: UUID
    var prompt: String
    var answer: String
    
    init(prompt: String, answer: String) {
        self.id = UUID()
        self.prompt = prompt
        self.answer = answer
        
    }
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
