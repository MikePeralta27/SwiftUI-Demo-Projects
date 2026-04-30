//
//  ContentView.swift
//  Navigation
//
//  Created by Michael Peralta on 4/21/26.
//

import SwiftUI

struct ContentView: View {
@State private var title = "SwiftUI"
    
    var body: some View {
        NavigationStack() {
           Text("Hello world")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        
        }
    }
}

#Preview {
    ContentView()
}
