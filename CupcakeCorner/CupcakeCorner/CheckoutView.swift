//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Michael Peralta on 5/6/26.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order

    @State private var confirmationMessage = ""
    @State private var showingConfirmation: Bool = false
    @State private var alertTitle = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(
                    url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
                    scale: 3
                ) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                Text(
                    "Your total cost is \(order.cost, format: .currency(code:"USD"))"
                )
                .font(.title)

                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()

            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(alertTitle, isPresented: $showingConfirmation) {
            Button("OK") {
                self.showingConfirmation.toggle()
            }
        } message: {
            Text(confirmationMessage)
        }
    }

    func placeOrder() async {
        // Convet data to json
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        // Tell swift how to send the data
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(
                for: request,
                from: encoded
            )

            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage =
                "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) Cupcake is on its way"
            alertTitle = "Order placed"
            showingConfirmation.toggle()
        } catch {
            print("Check out failed: \(error.localizedDescription)")
            alertTitle = "Order failed"
            confirmationMessage =
                "Check out failed: \(error.localizedDescription)"
            showingConfirmation.toggle()

        }

    }

}

#Preview {
    CheckoutView(order: Order())
}
