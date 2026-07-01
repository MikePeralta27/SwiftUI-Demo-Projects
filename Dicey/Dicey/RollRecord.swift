//
//  RollRecord.swift
//  Dicey
//
//  Created by Michael Peralta on 6/25/26.
//

import Foundation
import SwiftData

// 1. MODEL — @Model defines what SwiftData persists per roll
@Model
final class RollRecord {
    var date: Date
    var diceCount: Int
    var sides: Int
    var results: [Int]
    var total: Int
    
    init(diceCount: Int, sides: Int, results: [Int]) {
        self.date = .now
        self.diceCount = diceCount
        self.sides = sides
        self.results = results
        self.total = results.reduce(0, +)
    }
}
