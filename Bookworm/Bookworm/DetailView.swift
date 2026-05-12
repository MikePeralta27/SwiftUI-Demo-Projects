//
//  DetailView.swift
//  Bookworm
//
//  Created by Michael Peralta on 5/9/26.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert: Bool = false
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(Color.white)
                    .background(Color.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(Color.secondary)
            
            Text(book.date.formatted(date: .long, time: .omitted))
                .font(.caption)
            
            
            Text(book.review)
                .padding()
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
            
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
            
        } message: {
            Text("Are you sure you want to delete this book?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config )
        let example = Book(title: "test Book", author: "Test Author", genre: "Fantasy", review: "great Book", rating: 4)
        
        return DetailView(book: example)

    } catch {
        return Text("Error: \(error.localizedDescription)")
    }
}
