//
//  ContentView.swift
//  BetterRest
//
//  Created by Michael Peralta on 4/1/26.
//

import CoreML
import SwiftUI

struct ContentView: View {

    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeAmount = 1

    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    @State private var recommendedBedtime: Date?
    @State private var calculationError: String?

    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    if let bedtime = recommendedBedtime {
                        Text(bedtime.formatted(date: .omitted, time: .shortened))
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else if let calculationError {
                        Text(calculationError)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        Text("-")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            header: {
                    Text("Recommended bedtime")
                }
                Section("When do you want to wake up?") {
                    DatePicker(
                        "Please enter a date",
                        selection: $wakeUp,
                        displayedComponents: .hourAndMinute
                    )
                    .labelsHidden()
                }

                Section("Desired amount of sleep") {
                    Stepper(
                        "\(sleepAmount.formatted()) hours",
                        value: $sleepAmount,
                        in: 4...12,
                        step: 0.25
                    )
                }

                Section("Daily coffee intake") {
                    Picker("Number of cups", selection: $coffeAmount) {
                        ForEach(1...20, id: \.self) { amount in
                            Text("^[\(amount) cup](inflect: true)")
                        }
                    }
                }
            }
            .navigationTitle("BetterRest")
            .onAppear { updateRecommendedBedtime() }
            .onChange(of: wakeUp) { _, _ in updateRecommendedBedtime() }
            .onChange(of: sleepAmount) { _, _ in updateRecommendedBedtime() }
            .onChange(of: coffeAmount) { _, _ in updateRecommendedBedtime() }

        }
    }
    private func updateRecommendedBedtime() {
        calculationError = nil
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents(
                [.hour, .minute],
                from: wakeUp
            )
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeAmount)
            )
            recommendedBedtime = wakeUp - prediction.actualSleep
        } catch {
            recommendedBedtime = nil
            calculationError = "Sorry, there was a problem calculating your bedtime"
        }
    }
}
#Preview {
    ContentView()
}
