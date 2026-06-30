//
//  DiceSettingsView.swift
//  Dicey
//
//  Created by Michael Peralta on 6/25/26.
//

import SwiftUI

// 4. SETTINGS — @Binding writes diceCount/selectedSides back to parent
struct DiceSettingsView: View {
    @Binding var diceCount: Int
    @Binding var selectedSides: Int
    let diceSides: [Int]

    var body: some View {
        VStack(spacing: 12) {
            Stepper("Number of dice: \(diceCount)", value: $diceCount, in: 1...10)

            Picker("Dice type", selection: $selectedSides) {
                ForEach(diceSides, id: \.self) { sides in
                    Text("D\(sides)").tag(sides)
                }
            }
            .pickerStyle(.menu)
        }
        .padding()
    }
}

#Preview {
    DiceSettingsView(
        diceCount: .constant(3),
        selectedSides: .constant(20),
        diceSides: [4, 6, 8, 10, 12, 20, 100]
    )
}
