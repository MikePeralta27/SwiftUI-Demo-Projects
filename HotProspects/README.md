# HotProspects

SwiftUI **conference networking** demo from **100 Days of SwiftUI**: scan QR codes to save contacts, track who you have contacted, edit details, sort the list, bulk-delete entries, schedule reminders, and share your own QR code.

## Features

- **TabView** with four tabs: Everyone, Contacted, Uncontacted, and Me.
- **QR scanning** via [CodeScanner](https://github.com/twostraws/CodeScanner) in a sheet; parsed as `name\nemail` and saved to SwiftData.
- **SwiftData persistence** with `@Model`, `@Query`, `#Predicate`, and `modelContext` insert/delete.
- **Filtered lists** — the same `ProspectView` is reused with different `@Query` filters for contacted vs uncontacted tabs.
- **Sort menu** — name (A–Z) or most recent (`addedDate`) via a toolbar `Menu` + `Picker` and a computed `sortedProspects` array.
- **Inline NavigationLink** to an edit screen (`ProspectEditView`) with `@Bindable` two-way bindings (no Save button).
- **Swipe actions** — delete, mark contacted/uncontacted, and “Remind Me” local notification.
- **Multi-select delete** — `EditButton`, `List(selection:)`, and toolbar delete when rows are selected.
- **Me tab** — `@AppStorage` for your name and email, live **Core Image** QR generation, and **ShareLink** on the code image.

## Project layout

- `HotProspectsApp.swift` — app entry point and `.modelContainer(for: Prospect.self)`.
- `Prospect.swift` — SwiftData `@Model` (name, email, contacted flag, added date).
- `ContentView.swift` — `TabView` shell with three filtered `ProspectView` tabs plus `MeView`.
- `ProspectView.swift` — main list, scanner sheet, sort menu, swipe actions, notifications, bulk delete.
- `ProspectEditView.swift` — form to edit a prospect’s name and email.
- `MeView.swift` — profile fields, QR code display, and share context menu.

## Requirements

- **Xcode 15+** with Swift **5.9+**.
- **iOS 17+** (or project deployment target) for SwiftData, `NavigationStack`, and modern SwiftUI used here.
- **Camera** access when scanning QR codes on device (simulator uses simulated scan data).
- **Notification** permission when using “Remind Me” swipe action.

## Open in Xcode

1. Open `HotProspects.xcodeproj` in this folder.
2. Resolve Swift Package dependencies if prompted (**CodeScanner**).
3. Select a simulator or device and run (**⌘R**).
4. On **Me**, enter your name and email to generate your QR code.
5. On **Everyone** or **Uncontacted**, tap **Scan** to add a contact (simulator uses bundled test data).
6. Tap a row to edit, swipe for quick actions, or tap **Edit** to select multiple rows and delete.

**Simulator tip:** The scanner sheet uses `simulatedData: "Michael\nm.peralta@test.com"` so you can test without a physical QR code.

## Learn more

Patterns: **SwiftData** (`@Model`, `@Query`, `#Predicate`, `SortDescriptor`, `@Bindable`, `modelContext`), **TabView** navigation, **NavigationStack** with inline **NavigationLink**, **List** selection and **swipeActions**, **sheet** presentation, **toolbar** `Menu`/`Picker`, **UserNotifications**, **Core Image** QR generation, **`@AppStorage`**, and **ShareLink**.
