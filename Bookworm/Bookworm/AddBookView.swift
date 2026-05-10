//
//  AddBookView.swift
//  Bookworm
//
//  Created by Michael Peralta on 5/8/26.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var author: String = ""
    @State private var genre: String = ""
    @State private var review: String = ""
    @State private var rating: Int = 0

    let genres = [
        "Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller",
    ]

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section("Write a review") {
                    TextEditor(text: $review)

                    RatingView(rating: $rating)
                }

                Section {
                    Button("Add book") {
                        let newBook = Book(
                            title: title,
                            author: author,
                            genre: genre,
                            review: review,
                            rating: rating
                        )

                        modelContext.insert(newBook)
                        dismiss()

                    }
                }
            }
            .navigationTitle(Text("Add a book"))
        }
    }
}

#Preview {
    AddBookView()
}
