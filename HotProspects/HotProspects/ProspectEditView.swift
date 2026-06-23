//
//  ProspectEditView.swift
//  HotProspects
//
//  Created by Michael Peralta on 6/15/26.
//

import SwiftUI
import SwiftData

struct ProspectEditView: View {
    @Bindable var prospect: Prospect
    
    var body: some View {
        
            Form {
                TextField("Name",text: $prospect.name )
                    .textContentType(.name)
                TextField("Email", text: $prospect.emailAddress)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                
            }
            .navigationTitle("Edit Prospect")
        
    }
}

#Preview {
    ProspectEditView(prospect: Prospect(name: "Michael", emailAddress: "michelt@gmail.com", isContacted: false))
        .modelContainer(for: Prospect.self, inMemory: true)
}
