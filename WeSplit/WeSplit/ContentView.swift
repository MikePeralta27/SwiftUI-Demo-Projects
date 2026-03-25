//
//  ContentView.swift
//  WeSplit
//
//  Created by Michael Peralta on 3/23/26.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalPerPerson: Double {
        // Calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / max(peopleCount, 1)
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let tipselection: Double = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipselection
        return checkAmount + tipValue
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD"
                        )
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }

                Section("How much do you want to tip?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text(checkAmount / 100 * Double(tipPercentage),
                         format: .currency(
                             code: Locale.current.currency?.identifier ?? "USD"
                         ))
                }

                Section("Total Amount") {
                    Text(
                        grandTotal,
                        format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD"
                        )
                    )
                }

                Section("Amount per person") {
                    Text(
                        totalPerPerson,
                        format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD"
                        )
                    )
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
