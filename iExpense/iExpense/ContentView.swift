//
//  ContentView.swift
//  iExpense
//
//  Created by Michael Peralta on 4/13/26.
//
import Observation
import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode(
                [ExpenseItem].self,
                from: savedItems
            ) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false

    @ViewBuilder
    private func styledAmount(_ amount: Double, currencyCode: String) -> some View {
        let text = Text(amount, format: .currency(code: currencyCode))
        switch amount {
        case ..<10:
            text
                .foregroundStyle(.green)
                .fontWeight(.bold)
        case 10..<100:
            text
                .foregroundStyle(.orange)
                .fontWeight(.medium)
        default:
            text
                .foregroundStyle(.red)
                .fontWeight(.heavy)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.items.filter { $0.type == "Personal" }) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            styledAmount(item.amount, currencyCode: "USD")
                        }
                    }
                    .onDelete(perform: removePersonal)
                }
                
                Section("Business") {
                    ForEach(expenses.items.filter { $0.type == "Business" }) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            styledAmount(item.amount, currencyCode: "USD")
                        }
                    }
                    .onDelete(perform: removeBusiness)
                }
                
                Section("Other") {
                    ForEach(expenses.items.filter { $0.type == "Other" }) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            styledAmount(item.amount, currencyCode: Locale.current.currency?.identifier ?? "USD")
                        }
                    }
                    .onDelete(perform: removeOther)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
                
                EditButton()
                
            }
            .sheet(isPresented: $showingAddExpense) {
                //show and Add view here
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        // Default removal if needed; currently unused by sections
        expenses.items.remove(atOffsets: offsets)
    }
    
    func removePersonal(at offsets: IndexSet) {
        let filtered = expenses.items.enumerated().filter { $0.element.type == "Personal" }
        let idsToRemove = offsets.compactMap { index in
            filtered[safe: index]?.element.id
        }
        removeItems(withIDs: idsToRemove)
    }

    func removeBusiness(at offsets: IndexSet) {
        let filtered = expenses.items.enumerated().filter { $0.element.type == "Business" }
        let idsToRemove = offsets.compactMap { index in
            filtered[safe: index]?.element.id
        }
        removeItems(withIDs: idsToRemove)
    }

    func removeOther(at offsets: IndexSet) {
        let filtered = expenses.items.enumerated().filter { $0.element.type == "Other" }
        let idsToRemove = offsets.compactMap { index in
            filtered[safe: index]?.element.id
        }
        removeItems(withIDs: idsToRemove)
    }

    private func removeItems(withIDs ids: [UUID]) {
        expenses.items.removeAll { ids.contains($0.id) }
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    ContentView()
}
