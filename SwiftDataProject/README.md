# SwiftDataProject

Small **SwiftUI + SwiftData** demo: **`User`** models with a **cascade** relationship to **`Job`**, filtered **`@Query`** in **`UsersView`**, and sample data from **`ContentView`**.

## Features

- **`User`** / **`Job`** `@Model` types with `@Relationship(deleteRule: .cascade)`.
- **`SwiftDataProjectApp`**: `modelContainer(for: User.self)` for a local on-disk store.
- **`ContentView`**: navigation, toolbar actions that insert sample users.
- **`UsersView`**: `init` with **`#Predicate`** on join date and configurable **sort** descriptors.

## Requirements

- **Xcode 15+** and **iOS 17+** (or as set in the Xcode project) for the SwiftData APIs used here.

## Open in Xcode

1. Open `SwiftDataProject.xcodeproj` in this folder.
2. Run (**⌘R**) on a simulator or device.

## Learn more

SwiftData **`@Query`**, **`#Predicate`**, **`modelContext.insert`**, and relationship **cascade** behavior.
