//
//  ContentView.swift
//  Moonshot
//
//  Created by Michael Peralta on 4/17/26.
//

import SwiftUI

struct MissionCardView: View {
    let mission: Mission

    var body: some View {
        VStack {

            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()

            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))

            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
    }

}

struct MissionsListView: View {
    @State private var isGrid: Bool = true
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        ForEach(missions) { mission in
            NavigationLink {
                MissionView(
                    mission: mission,
                    astronauts: astronauts
                )
            } label: {
                MissionCardView(mission: mission)
            }
        }
    }
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var isGrid: Bool = true

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                if isGrid {
                    LazyVGrid(columns: columns) {
                        MissionsListView(missions: missions, astronauts: astronauts)
                        
                    }
                    .padding([.horizontal, .bottom])
                } else {
                    LazyVStack {
                        MissionsListView(missions: missions, astronauts: astronauts)
                    }
                    .padding([.horizontal])
                    .padding([.horizontal, .bottom])
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(action: {
                    self.isGrid.toggle()
                }) {
                    Image(
                        systemName: self.isGrid
                            ? "list.dash" : "square.grid.2x2"
                    )
                }
            }
        }

    }
}

#Preview {
    ContentView()
}

