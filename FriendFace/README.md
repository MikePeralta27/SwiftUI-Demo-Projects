# FriendFace

SwiftUI **social directory** demo from **100 Days of SwiftUI**: browse users from the Hacking with Swift sample API, cache them with **SwiftData**, and open a detail screen with profile info and friends.

## Features

- **`User`** / **`Friend`** `@Model` types: profile fields and a cascade relationship for each user’s friends list.
- **`UserDTO`** / **`FriendDTO`**: `Codable` structs for JSON decoding (network layer separate from persistence).
- **`FriendFaceApp`**: `modelContainer(for: [User.self, Friend.self])` for on-disk storage.
- **`ContentView`**: `@Query` sorted by name then age; fetches [friendface.json](https://www.hackingwithswift.com/samples/friendface.json) only when the store is empty; inserts mapped models via `modelContext`.
- **`UserDetailView`**: form with user information and a friends section.

## Project layout

- `FriendFaceApp.swift` — app entry and SwiftData container.
- `User.swift` — `@Model` user and `UserDTO`.
- `Friend.swift` — `@Model` friend and `FriendDTO`.
- `ContentView.swift` — list, network fetch, and persistence.
- `UserDetailView.swift` — user detail screen.

## Requirements

- **Xcode 15+** with Swift **5.9+**.
- **iOS 17+** (or project deployment target) for **SwiftData** as used here.
- Network access on first launch to download sample data.

## Open in Xcode

1. Open `FriendFace.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).

## Learn more

Patterns: **SwiftData** persistence, **`@Query`** with **`SortDescriptor`**, **`@Relationship`** cascade delete, **`modelContext.insert`**, async **`URLSession`** fetch, and **DTO → `@Model`** mapping for API data.
