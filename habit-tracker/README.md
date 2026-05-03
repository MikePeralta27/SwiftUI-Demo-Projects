# Habit Tracker

A SwiftUI **habit list** demo: add activities from a sheet (name, type, description), browse them in a list with **navigation by stable `UUID`**, open a **detail** form with live fields from shared state, and tap **Complete** to increment a **completion count** persisted as **JSON in `UserDefaults`**.

Uses **`NavigationStack(path:)`** with a small `Route` enum (`detail(UUID)`), **`navigationDestination(for:)`** to build `DetailsView`, **`ObservableObject`** / **`@Published`** on `Activities`, and **`Codable`** `Activity` models. The detail screen resolves the habit from `activities.items` by id so counts stay in sync with the store (no stale snapshot from the navigation path). **Complete** updates the array via a copy-and-assign pattern so `@Published` reliably notifies SwiftUI.

## Requirements

- Xcode 15+ with Swift 5.9+ (SwiftUI)
- iOS version as set in the Xcode project (SwiftUI features as used in the target)

## Open in Xcode

1. Open `habit-tracker.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).

## Learn more

Follows common **100 Days of SwiftUI**-style patterns: struct models, a single observable store, `NavigationLink(value:)`, and persistence in `didSet` after encoding the habit list.
