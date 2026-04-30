//
//  AddView.swift
//  iExpense
//
//  Created by Michael Peralta on 4/15/26.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "New Item Name"
    @State private var type = "Personal"
    @State private var amount: Double = 0.0
    
    var expenses: Expenses

    let types = ["Personal", "Business", "Other"]

    var body: some View {
//        NavigationStack {
            Form {
//                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField(
                    "Amount",
                    value: $amount,
                    format: .currency(code: "USD")
                )
                .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let items = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(items)
                    dismiss()
                    
                    
                    
                }
            }
        }
//    }
    
    
}

#Preview {
    AddView(expenses: Expenses())
}
