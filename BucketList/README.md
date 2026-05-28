# BucketList

SwiftUI **map bucket list** demo from **100 Days of SwiftUI**: mark places on a map, edit details, fetch nearby Wikipedia articles, and protect data with biometrics.

## Features

- **MapKit** map with `MapReader` tap-to-add pins and double-tap annotations to edit.
- **JSON persistence** of places in the documents directory with **complete file protection**.
- **Face ID / Touch ID** gate before the map is shown (`LocalAuthentication`).
- **Biometric error alerts** when authentication fails or is unavailable.
- **Map style picker** (Standard, Imagery, Hybrid) via toolbar segmented control.
- **Edit sheet** with name and description fields, Wikipedia geosearch for nearby pages, and save callback.
- **`@Observable` view models** for `ContentView` and `EditView` (dismiss and `onSave` stay in the view).

## Project layout

- `BucketListApp.swift` — app entry point.
- `ContentView.swift` / `ContentView-ViewModel.swift` — map UI, auth, locations, map style.
- `EditView.swift` / `EditView-ViewModel.swift` — place editor and Wikipedia fetch.
- `Location.swift` — codable place model with coordinates.
- `Result.swift` — Wikipedia API response types.

## Requirements

- **Xcode 15+** with Swift **5.9+**.
- **iOS 17+** (or project deployment target) for SwiftUI `Map`, `@Observable`, and modern MapKit APIs.
- **Face ID usage** string in the target (configured in the project).
- Network access for Wikipedia geosearch in the edit sheet.

## Open in Xcode

1. Open `BucketList.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).
3. Tap **Unlock places**, authenticate, then tap the map to add pins and double-tap a pin to edit.

## Learn more

Patterns: **MapKit** (`Map`, `Annotation`, `MapReader`, `mapStyle`), **`@Observable`** view models, **`LocalAuthentication`**, **Codable** file I/O with encryption, **async/await** networking, and **sheet**-based editing.
