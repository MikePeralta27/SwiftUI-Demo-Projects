//
//  ContentView.swift
//  habit-tracker
//
//  Created by Michael Peralta on 5/2/26.
//

import Combine
import SwiftUI

struct Activity: Identifiable, Codable, Equatable, Hashable {
    var id: UUID = UUID()
    var name: String
    var type: String
    var description: String
    var completionCount: Int
}

final class Activities: ObservableObject {
    @Published var items: [Activity] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "activities") {
            if let decodedItems = try? JSONDecoder().decode(
                [Activity].self,
                from: savedItems
            ) {
                items = decodedItems
                return
            }
        }
        items = []
    }

}

struct ContentView: View {
    private enum Route: Hashable {
        case detail(UUID)
    }
    @State private var path: [Route] = []
    
    @State private var isPresented: Bool = false

    @StateObject private var activities = Activities()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(activities.items) { activity in
                    NavigationLink(value: Route.detail(activity.id)) {
                        HStack {
                            Image(systemName: "circle")
                                .foregroundColor(.secondary)
                            Text(activity.name)
                            Spacer()
                            Text(activity.type)
                                .foregroundStyle(.secondary)
                        }
                        
                    }
                }
            }
            .navigationTitle("Habit Tracker")
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detail(let activityId):
                    DetailsView(activityId: activityId, activities: activities)
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add Activity")
                }
            }
            .sheet(isPresented: $isPresented) {
                AddView(activities: activities)
            }
        }
    }
}

#Preview {
    ContentView()
}
