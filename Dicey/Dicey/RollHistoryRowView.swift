//
//  RollHistoryRowView.swift
//  Dicey
//
//  Created by Michael Peralta on 6/25/26.
//

import SwiftUI

// 8. ROW — one RollRecord snapshot; accessibility label here
struct RollHistoryRowView: View {
    let roll: RollRecord

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(roll.date.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundStyle(.secondary)

            Text("\(roll.diceCount) × D\(roll.sides)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(roll.results.map(String.init).joined(separator: ", "))

            Text("Total: \(roll.total)")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.secondary.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(historyLabel(for: roll))
    }

    private func historyLabel(for roll: RollRecord) -> String {
        let dice = roll.results.map(String.init).joined(separator: ", ")
        return "Rolled \(dice) on \(roll.diceCount) \(roll.sides)-sided dice. Total \(roll.total)."
    }
}

#Preview {
    RollHistoryRowView(
        roll: RollRecord(diceCount: 3, sides: 20, results: [4, 2, 6])
    )
}
