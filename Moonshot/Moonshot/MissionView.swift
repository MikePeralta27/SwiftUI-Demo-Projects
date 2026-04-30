//
//  MissionView.swift
//  Moonshot
//
//  Created by Michael Peralta on 4/18/26.
//

import SwiftUI

// Crew struct
struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

// Mission image view struct
struct missionImageView: View {
    let mission: Mission

    var body: some View {
        Image(mission.image)
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) { width, axis in
                width * 0.6
            }
    }

    init(for mission: Mission) {
        self.mission = mission
    }
}

// horizonal scroll view for astronauts in mission details screen
struct AstronautsHorizontalView: View {
    let astronautsCrew: [CrewMember]

    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(astronautsCrew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(
                                            .white,
                                            lineWidth: 1
                                        )
                                )

                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)

                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))

                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }

    }
}


// Separator view

struct RectangleDividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(Color(.lightBackground))
            .padding(.vertical)
    }
}

// Title View
struct TitleView: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title.bold())
            .padding(.bottom, 5)
    }
}

// Launch date view
struct MissionLaunchDateView: View {
    var missionLaunchDate: Date?
    
    var body: some View {
        if let launchDate = missionLaunchDate {
            Text(launchDate, format: .dateTime.year().month().day())
        } else {
            Text("N/A")
        }
        
    }
    
    init(for missionLaunchDate: Date? = nil) {
        self.missionLaunchDate = missionLaunchDate
    }
}

struct MissionView: View {

    // Define initial values for the mission View
    let mission: Mission
    let crew: [CrewMember]

    var body: some View {
        ScrollView {
            VStack {
                //Mission image view
                missionImageView(for: mission)

               RectangleDividerView()

                VStack(alignment: .leading) {
                    TitleView(title: "Mission Highlights")
                    
                    MissionLaunchDateView(for: mission.launchDate)
                        .padding()
                        

                    Text(mission.description)

                    RectangleDividerView()


                    TitleView(title:"Crew")
                        
                }
                .padding(.horizontal)

                /// scroll crew
                AstronautsHorizontalView(astronautsCrew: crew)
                
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.lightBackground)
    }

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)

}
