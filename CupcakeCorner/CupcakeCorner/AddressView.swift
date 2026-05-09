//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Michael Peralta on 5/5/26.
//

import SwiftUI

struct AddressView: View {
    
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
                
                
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
                
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CheckoutView(order: Order())
}
