//
//  DetailsView.swift
//  habit-tracker
//
//  Created by Michael Peralta on 5/2/26.
//

import SwiftUI

struct DetailsView: View {
    var activityId: UUID
    @ObservedObject var activities: Activities

    private var current: Activity? {
        activities.items.first(where: { $0.id == activityId })
    }

    var body: some View {

        Group {
            if let activity = current {
                Form {
                    Section {
                        HStack {
                            Text("Name: ")
                                .font(Font.body.bold())
                            Spacer()
                            Text(activity.name)
                        }
                        HStack {
                            Text("Type: ")
                                .font(Font.body.bold())

                            Spacer()

                            Text(activity.type)
                        }
                        HStack {
                            Text("Description: ")
                                .font(Font.body.bold())

                            Spacer()

                            Text(activity.description)
                        }
                        HStack {
                            Text("Completed: ")
                                .font(Font.body.bold())

                            Spacer()

                            Text("\(activity.completionCount) times")
                        }

                        Button("Complete") {
                            var updated = activity
                            updated.completionCount += 1
                            if let index = activities.items.firstIndex(where: {
                                $0.id == activityId
                            }) {
                                var copy = activities.items
                                copy[index] = updated
                                activities.items = copy
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .navigationTitle(activity.name)

            } else {
                ContentUnavailableView(
                    "No activity found",
                    systemImage: "questionmark.circle"
                )
            }
        }

    }
}

#Preview {
    let store = Activities()
    let id = UUID()
    store.items = [
        Activity(
            id: id,
            name: "Read",
            type: "Reading",
            description: "20 min",
            completionCount: 0
        )
    ]
    return NavigationStack {
        DetailsView(activityId: id, activities: store)
    }
}
