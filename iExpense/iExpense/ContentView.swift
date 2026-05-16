//
//  ContentView.swift
//  iExpense
//
//  Created by Michael Peralta on 4/13/26.
//
import SwiftData
import SwiftUI


struct ContentView: View {
    
    private enum Route: Hashable {
        case add
        // case detail(id: UUID)  // example for later
    }
    @State private var path: [Route] = []

    @ViewBuilder
    private func styledAmount(_ amount: Double, currencyCode: String)
        -> some View
    {
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
    
    enum ExpenseSort: String, CaseIterable, Identifiable {
        case name
        case amount
        var id: String { rawValue }
        var descriptors: [SortDescriptor<ExpenseItem>] {
            switch self {
            case .name:
                [SortDescriptor(\ExpenseItem.name)]
            case .amount:
                [SortDescriptor(\ExpenseItem.amount)]
            }
        }
    }
    
    @State private var sortMode: ExpenseSort = .name


    var body: some View {
        NavigationStack(path: $path) {
            List {
                ExpensesSection(title: "Personal", expenseType: "Personal", sortDescriptors: sortMode.descriptors)

                ExpensesSection(title: "Business", expenseType: "Business", sortDescriptors: sortMode.descriptors)


                ExpensesSection(title: "Other", expenseType: "Other", sortDescriptors: sortMode.descriptors)
                

            }
            .navigationTitle("iExpense")
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .add:
                    AddView()
                }
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    path.append(.add)
                }

                EditButton()
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortMode) {
                        Text("Name").tag(ExpenseSort.name)
                        Text("Amount").tag(ExpenseSort.amount)
                    }
                }

            }
        }
    }


}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Preview failed: \(error.localizedDescription)")
    }
}

