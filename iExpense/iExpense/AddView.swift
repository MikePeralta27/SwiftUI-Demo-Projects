//
//  AddView.swift
//  iExpense
//
//  Created by Michael Peralta on 4/15/26.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var name = "New Item Name"
    @State private var type = "Personal"
    @State private var amount: Double = 0.0

    let types = ["Personal", "Business", "Other"]

    var body: some View {
        Form {
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
                let item = ExpenseItem(name: name, type: type, amount: amount)
                modelContext.insert(item)
                dismiss()
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: ExpenseItem.self,
            configurations: config
        )
        return AddView()
            .modelContainer(container)
    } catch {
        return Text("Preview failed: \(error.localizedDescription)")
    }
}
