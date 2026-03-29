//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michael Peralta on 3/25/26.
//

import SwiftUI

struct FlagImage: View {
    var flag: String
    
    var body: some View {
        Image(flag)
            .clipShape(.capsule)
            .shadow(radius: 5)
            
    }
}


struct ContentView: View {

    @State var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria",
        "Poland", "Spain", "UK", "Ukraine", "US",
    ].shuffled()

    @State var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreCount = 0
    @State private var questionCount = 1

    private let totalRounds = 8

    var alertTitle: String {
        if questionCount == totalRounds {
            "Game over!"
        } else {
            scoreTitle
        }
    }

    var alertMessage: String {
        if questionCount == totalRounds {
            "You scored \(scoreCount) out of \(totalRounds)."
        } else {
            "Your score so far: \(scoreCount) (round \(questionCount) of \(totalRounds))."
        }
    }

    var body: some View {

        ZStack {
            RadialGradient(
                stops: [
                    .init(
                        color: Color(red: 0.1, green: 0.2, blue: 0.45),
                        location: 0.0
                    ),
                    .init(color: .blue, location: 0.5),
                    .init(color: .red, location: 1.0),
                ],
                center: .top,
                startRadius: 200,
                endRadius: 700
            )
            .ignoresSafeArea()

            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tag the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(flag: countries[number])
                                
                        }
                    }
                }  // VStack 2
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()

                Text("Score: \(scoreCount)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()

            }  // VStack 1
            .padding()
        }  // ZStack
        .alert(alertTitle, isPresented: $showingScore) {
            if questionCount == totalRounds {
                Button("Play Again") {
                    scoreCount = 0
                    questionCount = 0
                    askQuestion()
                }
            } else {
                Button("Continue", action: askQuestion)
            }
        } message: {
            Text(alertMessage)
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreCount += 1
        } else {
            scoreTitle = "Wrong"
        }

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCount += 1
    }
}

#Preview {
    ContentView()
}
