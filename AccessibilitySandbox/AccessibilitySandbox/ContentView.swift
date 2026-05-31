//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Michael Peralta on 5/28/26.
//

import SwiftUI

struct ContentView: View {
    @State private var value = 10

    var body: some View {
        VStack {
            Text("Value: \(value)")
                .font(.title)

            Button("Adjust", action: {})
                .accessibilityAdjustableAction { direction in
                    switch direction {
                    case .increment:
                        value += 1
                    case .decrement:
                        value -= 1
                    default:
                        break
                    }
                }

            Image("character")
                .resizable()
                .scaledToFit()
                .accessibilityLabel("Your avatar character")

            Image("ales-krivec-15949")
                .resizable()
                .scaledToFit()
                .accessibilityHidden(true)

            Image("galina-n-189483")
                .resizable()
                .scaledToFit()
                .accessibilityLabel("Trees in the mist")

            Image("kevin-horstmann-141705")
                .resizable()
                .scaledToFit()
                .accessibilityHidden(true)

            Image("nicolas-tissot-335096")
                .resizable()
                .scaledToFit()
                .accessibilityLabel("An icy mountain side")

            VStack {
                Text("Paul Hudson")
                Text("Creator of Hacking with Swift")
            }
            .accessibilityElement(children: .combine)
        }
    }
}

#Preview {
    ContentView()
}
