//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Michael Peralta on 4/29/26.
//
import CoreHaptics
import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])

                        }
                    }

                    Stepper(
                        "Number of cakes: \(order.quantity)",
                        value: $order.quantity,
                        in: 3...20
                    )
                }

                Section {
                    Toggle(
                        "Any special requests",
                        isOn: $order.specialRequestEnabled.animation()
                    )
                    if order.specialRequestEnabled {
                        Toggle(
                            "Add extra frosting",
                            isOn: $order.extraFrosting
                        )
                        Toggle(
                            "Add extra sprinkles",
                            isOn: $order.extraSprinkles
                        )
                    }

                }
                
                Section {
                    NavigationLink("Delivery Details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle(Text("Cupcake Corner"))
        }

    }

}

#Preview {
    ContentView()
}
