//
//  ContentView.swift
//  Edutainment
//
//  Created by Michael Peralta on 4/9/26.
//

import SwiftUI

struct ContentView: View {

    enum ResultType {
        case correct
        case wrong
        case empty

        var title: String {
            switch self {
            case .correct:
                return "Correct"
            case .wrong:
                return "Wrong"
            case .empty:
                return "-"
            }
        }
    }

    @State private var tableNumber: Int = 2
    @State private var selectedQuestionAmount: Int = 5
    @State private var selectedQuestion: String = ""

    @State private var questionAmounts: [Int] = [5, 10, 15, 20]
    @State private var questions: [String: String] = [:]
    @State private var submittedAnwer: String = ""

    @State private var result: ResultType = .empty
    @State private var showAlert: Bool = false
    @State private var score: Int = 0
    @State private var presentedQuestionCount: Int = 0

    @State private var resultAnimationTrigger: Int = 0
    @State private var questionAnimationTrigger: Int = 0

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Stepper(
                        "Multiplication Table of \(tableNumber)  ",
                        value: $tableNumber,
                        in: 2...12,
                        step: 1
                    )
                }
                Section {
                    Picker(
                        "Question Amount",
                        selection: $selectedQuestionAmount
                    ) {
                        ForEach(questionAmounts, id: \.self) { amount in
                            Text("\(amount)")
                        }
                    }
                }

                Section("Question") {
                    Text(selectedQuestion)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .id(questionAnimationTrigger)
                    
                        .animation(.bouncy, value: questionAnimationTrigger)

                }

                Section("Answer") {
                    TextField("Enter your answer", text: $submittedAnwer)
                        .keyboardType(.decimalPad)
                        .onSubmit {

                            validateAnswer(answer: submittedAnwer)
                            submittedAnwer = ""

                        }
                }
                Section("Result") {
                    VStack {
                        Text(result.title)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .id(resultAnimationTrigger)
                            .transition(.scale.combined(with: .opacity))
                            .animation(.bouncy, value: resultAnimationTrigger)

                        Text("Score: \(score) / \(selectedQuestionAmount)")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                }
            }
            .navigationTitle("Edutainment")
            .onAppear {
                generateRamdonQuestions(selectedQuestionAmount)
            }
            .onChange(of: tableNumber) { _, _ in
                generateRamdonQuestions(selectedQuestionAmount)
            }
            .onChange(of: selectedQuestionAmount) { _, _ in
                generateRamdonQuestions(selectedQuestionAmount)
            }
            .alert("Game Over!", isPresented: $showAlert) {
                Button("New Game") {
                    resetGame()
                }

            } message: {
                Text(
                    "Your score is \(score) / \(selectedQuestionAmount). Do you want to play again?"
                )
            }

        }

    }

    func generateRamdonQuestions(_ QuestionAmount: Int) {
        var newQuestions: [String: String] = [:]
        guard QuestionAmount > 0 else {
            questions = [:]
            selectedQuestion = ""
            return
        }
        while newQuestions.count < QuestionAmount {
            let value = Int.random(in: 1...12)
            let answer = tableNumber * value
            let key = "\(tableNumber) x \(value)"
            // Only insert if it's not already present to guarantee uniqueness
            if newQuestions[key] == nil {
                newQuestions[key] = String(answer)
            }
        }
        questions = newQuestions
        presentedQuestionCount = 0
        if let firstKey = newQuestions.keys.randomElement() {
            withAnimation(.bouncy) {
                selectedQuestion = "  " + firstKey
                questionAnimationTrigger += 1
            }
        }
    }

    func validateAnswer(answer: String) {
        if answer.isEmpty { return }

        presentedQuestionCount += 1

        // Extract the key without the leading spaces we added when displaying
        let key = selectedQuestion.trimmingCharacters(in: .whitespaces)
        guard let correct = questions[key] else { return }
        if correct == answer {
            result = .correct
            score += 1
        } else {
            result = .wrong
        }
        
        withAnimation(.bouncy) {
            resultAnimationTrigger += 1
        }

        // If we've reached the target number of questions, end the game
        if presentedQuestionCount >= selectedQuestionAmount {
            showAlert = true
        } else {
            // Otherwise, pick the next question from the remaining pool
            if let nextKey = questions.keys.randomElement() {
                withAnimation(.bouncy) {
                    selectedQuestion = "  " + nextKey
                    questionAnimationTrigger += 1
                }
            }
        }

    }

    func resetGame() {
        score = 0
        presentedQuestionCount = 0
        selectedQuestion = ""
        resultAnimationTrigger = 0
        questionAnimationTrigger = 0
        generateRamdonQuestions(selectedQuestionAmount)
        showAlert.toggle()
    }
}

#Preview {
    ContentView()
}
