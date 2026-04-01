//
//  ContentView.swift
//  RockPaperAndScissors
//
//  Created by Michael Peralta on 3/29/26.
//

import SwiftUI

// MARK: - Game model

enum Move: CaseIterable, Equatable {
    case rock, paper, scissors

    var systemImageName: String {
        switch self {
        case .rock: return "gearshape"
        case .paper: return "text.document"
        case .scissors: return "scissors"
        }
    }

    var title: String {
        switch self {
        case .rock: return "Rock"
        case .paper: return "Paper"
        case .scissors: return "Scissors"
        }
    }
}

enum RoundOutcome: CaseIterable, Equatable {
    case win, lose, tie

    var title: String {
        switch self {
        case .win: return "Win"
        case .lose: return "Lose"
        case .tie: return "Tie"
        }
    }
}

/// Outcome for the **user** against the opponent.
private func outcome(for user: Move, vs opponent: Move) -> RoundOutcome {
    if user == opponent { return .tie }
    switch (user, opponent) {
    case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
        return .win
    default:
        return .lose
    }
}

// MARK: - Views

struct PlayButtonText: View {
    var playName: String

    var body: some View {
        Text(playName)
            .foregroundStyle(Color.primary)
            .clipShape(.rect(cornerRadius: 20))
            .frame(width: 160, height: 30)
            .bold()
            .font(.largeTitle)
    }
}

struct ContentView: View {
    private let maxRounds = 10

    @State private var opponentMove: Move = .rock
    @State private var expectedOutcome: RoundOutcome = .win
    @State private var scoreCount = 0
    /// Rounds finished after the user taps Continue on the result alert.
    @State private var completedRounds = 0
    @State private var showingFeedback = false
    @State private var showingGameOver = false
    @State private var feedbackTitle = ""
    @State private var feedbackMessage = ""

    private var currentRoundDisplay: Int {
        min(completedRounds + 1, maxRounds)
    }

    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(
                        color: Color(red: 0.3, green: 0.2, blue: 0.6),
                        location: 0.0
                    ),
                    .init(color: .blue, location: 0.5),
                    .init(color: .green, location: 1.0),
                ],
                center: .top,
                startRadius: 200,
                endRadius: 700
            )
            .ignoresSafeArea()

            VStack {
                Spacer()
                Text("Rock Paper Scissors")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Spacer()
                VStack(spacing: 15) {
                    VStack(spacing: 20) {
                        Text("🤖")
                            .font(.largeTitle)
                            .scaleEffect(2)

                        Text("Opponent plays:")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                    }

                    Text(opponentMove.title)
                        .font(.largeTitle.weight(.semibold))

                    VStack(spacing: 4) {
                        Text("Play to:")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(expectedOutcome.title)
                            .font(
                                .system(
                                    size: 36,
                                    weight: .bold,
                                    design: .rounded
                                )
                            )
                            .foregroundStyle(.primary)
                    }

                    Text("Round \(currentRoundDisplay) of \(maxRounds)")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)

                    ForEach(Move.allCases, id: \.self) { move in
                        Button {
                            userPlayed(move)
                        } label: {
                            PlayButtonText(playName: move.title)
                        }
                    }
                    .padding()
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(radius: 10)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(radius: 10)
                .disabled(showingFeedback)

                Spacer()

                Text("Score: \(scoreCount)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .onAppear(perform: startRound)
        .alert(feedbackTitle, isPresented: $showingFeedback) {
            Button("Continue", action: continueAfterRound)
        } message: {
            Text(feedbackMessage)
        }
        .alert("Game over!", isPresented: $showingGameOver) {
            Button("Restart", action: restartGame)
        } message: {
            Text(
                "You played \(maxRounds) rounds.\nFinal score: \(scoreCount) correct."
            )
        }
    }

    private func startRound() {
        opponentMove = Move.allCases.randomElement() ?? .rock
        expectedOutcome = RoundOutcome.allCases.randomElement() ?? .win
    }

    private func continueAfterRound() {
        completedRounds += 1
        if completedRounds >= maxRounds {
            // Present after the round alert finishes dismissing (reliable on iOS).
            DispatchQueue.main.async {
                showingGameOver = true
            }
        } else {
            startRound()
        }
    }

    private func restartGame() {
        scoreCount = 0
        completedRounds = 0
        showingGameOver = false
        startRound()
    }

    private func userPlayed(_ userMove: Move) {
        let actual = outcome(for: userMove, vs: opponentMove)
        if actual == expectedOutcome {
            feedbackTitle = "Correct"
            scoreCount += 1
        } else {
            feedbackTitle = "Wrong"
        }
        feedbackMessage = """
        You chose \(userMove.title) vs \(opponentMove.title) → \(actual.title). \
        Goal was: \(expectedOutcome.title).

        Score: \(scoreCount)
        """
        showingFeedback = true
    }
}

#Preview {
    ContentView()
}
