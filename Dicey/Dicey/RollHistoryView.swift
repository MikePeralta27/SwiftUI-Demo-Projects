//
//  RollHistoryView.swift
//  Dicey
//
//  Created by Michael Peralta on 6/25/26.
//

import SwiftUI

// 7. HISTORY — receives pastRolls from parent @Query; read-only
struct RollHistoryView: View {
    let pastRolls: [RollRecord]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Previous rolls")
                .font(.headline)
                .padding(.horizontal)

            if pastRolls.isEmpty {
                ContentUnavailableView(
                    "No rolls yet",
                    systemImage: "dice",
                    description: Text("Roll the dice to see history here.")
                )
            } else {
                ForEach(pastRolls) { roll in
                    RollHistoryRowView(roll: roll)
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    RollHistoryView(
        pastRolls: [
            RollRecord(diceCount: 3, sides: 20, results: [4, 2, 6]),
            RollRecord(diceCount: 1, sides: 6, results: [5]),
        ]
    )
}
