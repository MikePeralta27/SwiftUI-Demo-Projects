//
//  ContentView.swift
//  WordScramble
//
//  Created by Michael Peralta on 4/3/26.
//
import UIKit
import SwiftUI

struct ContentView: View {

    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord: String = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    private var score: Int {
        usedWords.count // or any of the formulas above
    }
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)

                }

                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)

                        }
                    }
                }
                
                Section {
                    Text("Score: \(score)")
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("Restart", action: startGame)
            }
        }

    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard answer.count > 0 else { return }

        // Disallow answers shorter than three letters
        guard answer.count >= 3 else {
            wordError(title: "Too short", message: "Words must be at least 3 letters long.")
            return
        }

        // Disallow answers that are exactly the root word
        guard answer != rootWord else {
            wordError(title: "Same as start word", message: "Please enter a different word than the start word.")
            return
        }

        // extra validations to come

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        guard isPossible(word: answer) else {
            wordError(
                title: "Word not possible",
                message: "You can't spell that word from '\(rootWord)'!"
            )
            return
        }

        guard isReal(word: answer) else {
            wordError(
                title: "Word not recognized",
                message: "You can't just make them up, you know!"
            )
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)

        }
        newWord = ""
    }

    func startGame() {
        if let startWordURL = Bundle.main.url(
            forResource: "start",
            withExtension: "txt"
        ) {
            if let startWords = try? String(
                contentsOf: startWordURL,
                encoding: .utf8
            ) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }

        }
        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true

    }
}

#Preview {
    ContentView()
}

