//
//  ContentView.swift
//  Unit-Converter
//
//  Created by Michael Peralta on 3/24/26.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue: Double = 0.0
    @State private var selectedUnit: String = "Length"
    @State private var inputUnit: String = "Meters"
    @State private var outputUnit: String = "Feet"
    var outputValue: Double {
        switch selectedUnit {
        case "Temp":
            return convertTemperature(
                value: inputValue,
                from: inputUnit,
                to: outputUnit
            )

        case "Length":
            return convertLength(
                value: inputValue,
                from: inputUnit,
                to: outputUnit
            )
        case "Time":
            return convertTime(
                value: inputValue,
                from: inputUnit,
                to: outputUnit
            )

        case "Volume":
            return convertVolume(
                value: inputValue,
                from: inputUnit,
                to: outputUnit
            )
        default:
            return inputValue
        }
    }

    @FocusState private var valueIsFocused: Bool

    let units: [String] = ["Temp", "Length", "Time", "Volume"]
    let temperatures: [String] = ["Celsius", "Fahrenheit", "Kelvin"]
    let lengths: [String] = [
        "Meters", "Feet", "Inches", "Kilometers", "Yards", "Miles",
    ]
    let times: [String] = ["Miliseconds", "Seconds", "Minutes", "Hours"]
    let volumes: [String] = [
        "Liters", "Gallons", "Milliliters", "Cups", "pints",
    ]

    var body: some View {
        NavigationStack {
            Form {
                Picker("Unit Type", selection: $selectedUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedUnit) { _, newCategory in
                    switch newCategory {
                    case "Temp":
                        inputUnit = "Celsius"
                        outputUnit = "Fahrenheit"
                    case "Length":
                        inputUnit = "Meters"
                        outputUnit = "Feet"
                    case "Time":
                        inputUnit = "Miliseconds"  // match your `times` spelling
                        outputUnit = "Seconds"
                    case "Volume":
                        inputUnit = "Liters"
                        outputUnit = "Gallons"
                    default:
                        break
                    }
                }

                Section("Enter Value") {
                    TextField(
                        "Value to Convert",
                        value: $inputValue,
                        format: .number
                            .locale(Locale(identifier: "en_US"))
                            .grouping(.automatic)
                            .precision(.fractionLength(0...2))
                    )
                    .keyboardType(.numberPad)
                    .focused($valueIsFocused)
                }  // Section 1

                Section("Select Units") {
                    Picker("From", selection: $inputUnit) {
                        switch selectedUnit {
                        case "Temp":
                            ForEach(temperatures, id: \.self) {
                                Text($0)
                            }
                        case "Length":
                            ForEach(lengths, id: \.self) {
                                Text($0)
                            }
                        case "Time":
                            ForEach(times, id: \.self) {
                                Text($0)
                            }
                        case "Volume":
                            ForEach(volumes, id: \.self) {
                                Text($0)
                            }
                        default:
                            Text("Error")
                        }
                    }  // First picker

                    Picker("To", selection: $outputUnit) {
                        switch selectedUnit {
                        case "Temp":
                            ForEach(temperatures, id: \.self) {
                                Text($0)
                            }
                        case "Length":
                            ForEach(lengths, id: \.self) {
                                Text($0)
                            }
                        case "Time":
                            ForEach(times, id: \.self) {
                                Text($0)
                            }
                        case "Volume":
                            ForEach(volumes, id: \.self) {
                                Text($0)
                            }
                        default:
                            Text("Error")
                        }
                    }  // seccount picker
                }  // Section 2

                Section("Result") {
                    Text("\(outputValue, specifier: "%.2f") \(outputUnit)")
                }

            }  //Form end
            .navigationTitle("Unit Converter")
            .toolbar {
                if valueIsFocused {
                    Button("Done") {
                        valueIsFocused = false
                    }
                }
            }
        }
    }

    /// Converts `value` expressed in `from` to the same quantity expressed in `to`.
    func convertTemperature(value: Double, from: String, to: String) -> Double {
        let celsius = temperatureToCelsius(value, from: from)
        return temperatureFromCelsius(celsius, to: to)
    }
    private func temperatureToCelsius(_ value: Double, from: String) -> Double {
        switch from {
        case "Celsius":
            return value
        case "Fahrenheit":
            return (value - 32) * 5 / 9
        case "Kelvin":
            return value - 273.15
        default:
            return value
        }
    }
    private func temperatureFromCelsius(_ celsius: Double, to: String) -> Double
    {
        switch to {
        case "Celsius":
            return celsius
        case "Fahrenheit":
            return celsius * 9 / 5 + 32
        case "Kelvin":
            return celsius + 273.15
        default:
            return celsius
        }
    }

    /// Converts `value` in `from` length unit to `to` (via meters).
    func convertLength(value: Double, from: String, to: String) -> Double {
        let meters = lengthToMeters(value, from: from)
        return lengthFromMeters(meters, to: to)
    }
    private func lengthToMeters(_ value: Double, from: String) -> Double {
        switch from {
        case "Meters": return value
        case "Feet": return value * 0.3048
        case "Inches": return value * 0.0254
        case "Kilometers": return value * 1000
        case "Yards": return value * 0.9144
        case "Miles": return value * 1609.344
        default: return value
        }
    }
    private func lengthFromMeters(_ meters: Double, to: String) -> Double {
        switch to {
        case "Meters": return meters
        case "Feet": return meters / 0.3048
        case "Inches": return meters / 0.0254
        case "Kilometers": return meters / 1000
        case "Yards": return meters / 0.9144
        case "Miles": return meters / 1609.344
        default: return meters
        }
    }

    /// Converts `value` in `from` time unit to `to` (via seconds).
    func convertTime(value: Double, from: String, to: String) -> Double {
        let seconds = timeToSeconds(value, from: from)
        return timeFromSeconds(seconds, to: to)
    }
    private func timeToSeconds(_ value: Double, from: String) -> Double {
        switch from {
        case "Miliseconds": return value / 1000
        case "Seconds": return value
        case "Minutes": return value * 60
        case "Hours": return value * 3600

        default: return value
        }
    }
    private func timeFromSeconds(_ seconds: Double, to: String) -> Double {
        switch to {
        case "Miliseconds": return seconds * 1000
        case "Seconds": return seconds
        case "Minutes": return seconds / 60
        case "Hours": return seconds / 3600
        default: return seconds
        }
    }

    /// Converts `value` in `from` volume unit to `to` via **liters** (US liquid cup / pint / gallon).
    func convertVolume(value: Double, from: String, to: String) -> Double {
        let liters = volumeToLiters(value, from: from)
        return volumeFromLiters(liters, to: to)
    }
    private func volumeToLiters(_ value: Double, from: String) -> Double {
        switch from {
        case "Liters": return value
        case "Milliliters": return value / 1000
        case "Gallons": return value * 3.785411784  // US liquid gallon → L
        case "Cups": return value * 0.2365882365  // US cup (8 fl oz) → L
        case "pints": return value * 0.473176473  // US liquid pint → L
        default: return value
        }
    }
    private func volumeFromLiters(_ liters: Double, to: String) -> Double {
        switch to {
        case "Liters": return liters
        case "Milliliters": return liters * 1000
        case "Gallons": return liters / 3.785411784
        case "Cups": return liters / 0.2365882365
        case "pints": return liters / 0.473176473
        default: return liters
        }
    }
}

#Preview {
    ContentView()
}
