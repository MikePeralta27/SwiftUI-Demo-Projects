//
//  ContentView.swift
//  Dicey
//
//  Created by Michael Peralta on 6/25/26.
//

import SwiftData
import SwiftUI
import UIKit

// 3. COORDINATOR — owns @State, @Query, roll(); composes subviews
struct ContentView: View {

    @Environment(\.modelContext) private var modelContext

    @Query(sort: \RollRecord.date, order: .reverse)
    private var pastRolls: [RollRecord]

    private let diceSides: [Int] = [4, 6, 8, 10, 12, 20, 100]

    @State private var selectedSides: Int = 6
    @State private var diceCount = 1

    @State private var displayValues: [Int] = [1]
    @State private var isRolling = false
    @State private var rollTimer: Timer?

    var currentTotal: Int {
        displayValues.reduce(0, +)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    DiceSettingsView(
                        diceCount: $diceCount,
                        selectedSides: $selectedSides,
                        diceSides: diceSides
                    )

                    DiceDisplayView(
                        displayValues: displayValues,
                        diceCount: diceCount,
                        selectedSides: selectedSides,
                        currentTotal: currentTotal,
                        isRolling: isRolling,
                        onRoll: roll
                    )

                    RollHistoryView(pastRolls: pastRolls)
                }
            }
            .navigationTitle("Dicey")
            .onChange(of: diceCount) { _, newCount in
                displayValues = Array(repeating: 1, count: newCount)
            }
            .onDisappear {
                rollTimer?.invalidate()
                rollTimer = nil
                isRolling = false
            }
        }
    }

    private func playRollHaptic() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }

    // 6. ROLL — finalResults once; Timer flickers displayValues; then save
    private func roll() {
        guard !isRolling else { return }

        isRolling = true
        displayValues = Array(repeating: 1, count: diceCount)

        let finalResults = (0..<diceCount).map { _ in
            Int.random(in: 1...selectedSides)
        }

        var ticks = 0
        let maxTicks = 15

        rollTimer?.invalidate()
        rollTimer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { timer in
            ticks += 1

            displayValues = (0..<diceCount).map { _ in
                Int.random(in: 1...selectedSides)
            }

            if ticks >= maxTicks {
                timer.invalidate()
                rollTimer = nil
                displayValues = finalResults
                playRollHaptic()
                isRolling = false

                let record = RollRecord(
                    diceCount: diceCount,
                    sides: selectedSides,
                    results: finalResults
                )
                modelContext.insert(record)

                let values = finalResults.map(String.init).joined(separator: ", ")
                let announcement = diceCount > 1
                    ? "Rolled \(values). Total \(finalResults.reduce(0, +))."
                    : "Rolled \(values)."
                UIAccessibility.post(notification: .announcement, argument: announcement)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: RollRecord.self, inMemory: true)
}
