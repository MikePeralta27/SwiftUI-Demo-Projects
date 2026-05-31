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
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes, Top striope blue, middle stripe white, bottom stripe black.",
        "France": "Flag with three vertical stripes, left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with  three horizontal stripes. Tup stripe black, middle stripe red, buttton stripe gold",
        "Ireland": "Flag with three vertical stripes. left stripe geen, middle stripe white, right stripe red.",
        "Italy": "Flag with three vertical stripes. Left stripe green, midle stripe whilte, right stripe green.",
        "Monaco": "",
        "Nigeria": "Flg with tree vertical stripes. left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, button stripe red.",
        "Spain": "Flag three horizontal stripes. Tup stp thin stripe red, middle thick stripe is gold with crest on the left, bottom stripe thin strip red.",
        "UK": "Flag with ovrlaping red and white crosses, both straight and diagonally, on a blue background",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom sirp yelow.",
        "US": "Flag with many red and white stripes, with white starts on a blus background in the top-left corner."
]

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
                        
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])}
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
