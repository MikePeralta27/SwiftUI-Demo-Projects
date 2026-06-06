# FaceRecall

SwiftUI **conference contacts** demo from **100 Days of SwiftUI** (Hot Prospects challenge): import a photo with **PhotosPicker**, name the person immediately, browse a sorted list, and view a full-size detail screen. Data persists with **SwiftData**.

## Features

- **PhotosPicker** in the toolbar to import images from the photo library as `Data`.
- **Naming alert** shown right after import so each photo gets a label before it is saved.
- **Sorted list** of named photos with thumbnail and name via `@Query(sort: \NamedPhoto.name)`.
- **Detail screen** with a full-size `scaledToFit` image and inline navigation title.
- **Swipe to delete** removes entries from the SwiftData store.
- **SwiftData persistence** with `@Attribute(.externalStorage)` for efficient image storage.

## Project layout

- `FaceRecallApp.swift` — app entry point and `.modelContainer(for: NamedPhoto.self)`.
- `NamedPhoto.swift` — SwiftData `@Model` (id, name, photo data).
- `ContentView.swift` — list, picker, naming alert, insert/delete.
- `DetailView.swift` — full-size photo detail.

## Requirements

- **Xcode 15+** with Swift **5.9+**.
- **iOS 17+** (or project deployment target) for PhotosPicker, SwiftData, and modern SwiftUI APIs used here.
- Photo library access when picking images on device.

## Open in Xcode

1. Open `FaceRecall.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).
3. Tap **+** to import a photo, enter a name in the alert, then tap a list row for the detail view.
4. Swipe left on a row to delete a contact.

## Learn more

Patterns: **PhotosUI** (`PhotosPicker`, `loadTransferable`), **SwiftData** (`@Model`, `@Query`, `modelContext.insert` / `delete`, `.modelContainer`, `@Attribute(.externalStorage)`), **NavigationStack** with `navigationDestination`, and alert-based data entry.
