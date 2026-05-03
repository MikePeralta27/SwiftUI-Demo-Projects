//
//  SwiftUIView.swift
//  habit-tracker
//
//  Created by Michael Peralta on 5/2/26.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    var activities: Activities
     
    var types: [String] = ["Workout", "Exercise", "Reading", "Other"]
    @State private var name: String = ""
    @State private var selectedType: String = "Workout"
    @State private var description: String = ""
    @State private var completionCount: Int = 0
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                    
                    Picker("Type", selection: $selectedType) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                        
                    }
                    
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle(Text("Add new Habit"))
            .toolbar {
                Button("Save") {
                    let item = Activity(name: name, type: selectedType, description: description, completionCount: completionCount)
                    activities.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(activities: Activities())
}
