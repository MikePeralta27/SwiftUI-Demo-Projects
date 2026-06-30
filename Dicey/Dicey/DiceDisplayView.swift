//
//  DiceDisplayView.swift
//  Dicey
//
//  Created by Michael Peralta on 6/25/26.
//

import SwiftUI

// 5. DISPLAY — read-only props + onRoll closure; no Timer or SwiftData
struct DiceDisplayView: View {
    private let dicePerRow = 5
    private let dieSize: CGFloat = 56
    private let dieSpacing: CGFloat = 16

    let displayValues: [Int]
    let diceCount: Int
    let selectedSides: Int
    let currentTotal: Int
    let isRolling: Bool
    let onRoll: () -> Void

    private var diceColumns: [GridItem] {
        Array(
            repeating: GridItem(.fixed(dieSize), spacing: dieSpacing),
            count: dicePerRow
        )
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Dice")
                .font(.title)

            LazyVGrid(columns: diceColumns, spacing: dieSpacing) {
                ForEach(displayValues.indices, id: \.self) { index in
                    Text("\(displayValues[index])")
                        .font(.largeTitle.bold())
                        .frame(width: dieSize, height: dieSize)
                        .background(.secondary.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .accessibilityLabel("Die \(index + 1)")
                        .accessibilityValue("\(displayValues[index])")
                }
            }
            .frame(maxWidth: .infinity)
            .accessibilityElement(children: .contain)
            .accessibilityAddTraits(isRolling ? .updatesFrequently : [])

            if diceCount > 1 {
                Text("Total: \(currentTotal)")
                    .font(.title2.bold())
                    .accessibilityLabel("Total rolled")
                    .accessibilityValue("\(currentTotal)")
            }

            Button(action: onRoll) {
                Text("Roll")
                    .font(.default.bold())
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(.capsule)
            .disabled(isRolling)
            .accessibilityLabel("Roll dice")
            .accessibilityHint("Rolls \(diceCount) \(selectedSides)-sided dice")
        }
        .padding()
    }
}

#Preview("Three dice") {
    DiceDisplayView(
        displayValues: [4, 2, 6],
        diceCount: 3,
        selectedSides: 20,
        currentTotal: 12,
        isRolling: false,
        onRoll: {}
    )
}

#Preview("Ten dice wrapped") {
    DiceDisplayView(
        displayValues: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        diceCount: 10,
        selectedSides: 6,
        currentTotal: 55,
        isRolling: false,
        onRoll: {}
    )
}
