//
//  ExpensesSection.swift
//  iExpense
//
//  Created by Michael Peralta on 5/15/26.
//
import SwiftData
import SwiftUI

struct ExpensesSection: View {
    
    @Environment(\.modelContext) private var modelContext
    let title: String
    let expenseType: String
    let sortDescriptors: [SortDescriptor<ExpenseItem>]
    
    @Query private var items: [ExpenseItem]
    
    init(title: String, expenseType: String, sortDescriptors: [SortDescriptor<ExpenseItem>]) {
        self.title = title
        self.expenseType = expenseType
        self.sortDescriptors = sortDescriptors
        
        _items = Query(
            filter: #Predicate<ExpenseItem> { $0.type == expenseType },
            sort: sortDescriptors
        )
    }
    
    var body: some View {
        Section(title) {
            ForEach(items) { item in
                Text(item.name)
                
            }
            
            .onDelete (perform: deleteItems)
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        withAnimation(.spring()) {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
       
    }
}

#Preview {
    ExpensesSection(title: "Test", expenseType: "Personal", sortDescriptors: [SortDescriptor(\ExpenseItem.name)])
        .modelContainer(for: ExpenseItem.self)
}
