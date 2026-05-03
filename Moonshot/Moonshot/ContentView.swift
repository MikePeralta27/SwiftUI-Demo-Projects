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

struct GridLayout: View {
    let missions: [Mission]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    MissionCardView(mission: mission)
                }
            }
        }
    }
}

struct ListLayout: View {
    let missions: [Mission]

    var body: some View {
        LazyVStack {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    MissionCardView(mission: mission)
                }
            }
        }
    }
}

struct MissionsListView: View {
    let missions: [Mission]

    var body: some View {
        ForEach(missions) { mission in
            NavigationLink(value: mission) {
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

                    GridLayout(
                        missions: missions
                    )
                    .padding([.horizontal, .bottom])

                } else {

                    ListLayout(
                        missions: missions
                    )

                    .padding(
                        EdgeInsets(
                            top: 0,
                            leading: 80,
                            bottom: 30,
                            trailing: 80
                        )
                    )
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
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
        }

    }
}

#Preview {
    ContentView()
}
