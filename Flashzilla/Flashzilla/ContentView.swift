//
//  ContentView.swift
//  Flashzilla
//
//  Created by Michael Peralta on 6/19/26.
//

import Combine
import SwiftData
import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

@MainActor
struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor)
    var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled)
    var accessibilityVoiceOverEnabled

    @Query private var savedCards: [Card]
    @State private var cards = [Card]()
    @State private var showingEditScreen: Bool = false

    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @Environment(\.scenePhase) var scenePhase
    @State private var isActive: Bool = true

    var body: some View {

        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea(edges: .all)
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                ZStack {
                    ForEach(cards, id: \.id) { card in
                        let index =
                            cards.firstIndex(where: { $0.id == card.id }) ?? 0

                        CardView(card: card) { wasCorrect in
                            withAnimation {
                                removeCard(card, wasCorrect: wasCorrect)
                            }
                        }
                        .stacked(at: index, in: self.cards.count)
                        .allowsHitTesting(index == cards.count - 1)
                        .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsTightening(timeRemaining > 0)

                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(Color.black)
                        .clipShape(.capsule)
                }
            }
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
            }

            if accessibilityDifferentiateWithoutColor
                || accessibilityVoiceOverEnabled
            {
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            if let card = cards.last {
                                withAnimation {
                                    removeCard(card, wasCorrect: false)
                                }
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being wrong")

                        Spacer()

                        Button {
                            if let card = cards.last {
                                withAnimation {
                                    removeCard(card, wasCorrect: true)
                                }
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct")

                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }

            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
        }
        .onAppear(perform: resetCards)
    }

    func removeCard(_ card: Card, wasCorrect: Bool) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }) else {
            return
        }

        cards.remove(at: index)

        if wasCorrect == false {
            cards.insert(card, at: 0)
        }

        if cards.isEmpty {
            isActive = false
        }
    }

    func resetCards() {
        timeRemaining = 100
        isActive = true
        cards = savedCards
    }
}

#Preview {
    ContentView()
}
