# iExpense

A SwiftUI **expense tracker** with three categories—**Personal**, **Business**, and **Other**. Add items from a sheet, see amounts with **color styling** by size (green under 10, orange under 100, red otherwise), swipe to delete within each section, and keep data across launches with **JSON in `UserDefaults`**.

Uses the **Observation** framework (`@Observable` on `Expenses`), `NavigationStack`, grouped `List` sections, and a currency-formatted amount field on the add form.

## Requirements

- Xcode 15+ with Swift 5.9+ (SwiftUI)
- iOS version as set in the Xcode project (typically **iOS 17+** for `@Observable`)

## Open in Xcode

1. Open `iExpense.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).

## Learn more

Follows the common **iExpense** pattern: a codable model, an observable store with `didSet` persistence, toolbar add/edit actions, and sectioned filtering by expense type.
