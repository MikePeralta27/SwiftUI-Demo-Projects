# FaceRecall

SwiftUI **conference contacts** demo from **100 Days of SwiftUI** (Hot Prospects challenge): import a photo with **PhotosPicker**, name the person immediately, browse a sorted list, view a full-size detail screen, and see where the contact was saved on a map. Data persists with **SwiftData**.

## Features

- **PhotosPicker** in the toolbar to import images from the photo library as `Data`.
- **Naming alert** shown right after import so each photo gets a label before it is saved.
- **Sorted list** of named photos with thumbnail and name via `@Query(sort: \NamedPhoto.name)`.
- **Detail screen** with a full-size `scaledToFit` image and inline navigation title.
- **Map pin** on the detail screen showing where the contact was saved (“Saved near here”), with a clear empty state when location was unavailable.
- **Core Location** via `LocationFetcher` to capture device coordinates at save time (optional — contacts still save without GPS).
- **Swipe to delete** removes entries from the SwiftData store.
- **SwiftData persistence** with `@Attribute(.externalStorage)` for efficient image storage and `latitude`/`longitude` for map coordinates.

## Project layout

- `FaceRecallApp.swift` — app entry point and `.modelContainer(for: NamedPhoto.self)`.
- `NamedPhoto.swift` — SwiftData `@Model` (id, name, photo data, optional location).
- `ContentView.swift` — list, picker, naming alert, location fetch, insert/delete.
- `DetailView.swift` — full-size photo and map annotation.
- `LocationFetcher.swift` — `CLLocationManager` wrapper for when-in-use location.

## Requirements

- **Xcode 15+** with Swift **5.9+**.
- **iOS 17+** (or project deployment target) for PhotosPicker, SwiftData, MapKit SwiftUI APIs, and modern SwiftUI used here.
- Photo library access when picking images on device.
- Location permission when saving map coordinates (optional; denied or unavailable location still allows saving contacts).

## Open in Xcode

1. Open `FaceRecall.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).
3. Tap **+** to import a photo, enter a name in the alert, then tap a list row for the detail view.
4. On the detail screen, view the photo and map pin (if location was available when saved).
5. Swipe left on a row to delete a contact.

**Simulator tip:** Set a simulated location under **Features → Location** to test the map pin.

## Learn more

Patterns: **PhotosUI** (`PhotosPicker`, `loadTransferable`), **SwiftData** (`@Model`, `@Query`, `modelContext.insert` / `delete`, `.modelContainer`, `@Attribute(.externalStorage)`), **MapKit** (`Map`, `Annotation`, `MapCameraPosition`), **Core Location** (`CLLocationManagerDelegate`), **NavigationStack** with `navigationDestination`, and alert-based data entry.
