# CupcakeCorner

SwiftUI **cupcake ordering** demo from **100 Days of SwiftUI**: pick cake type and quantity, optional special requests (extra frosting / sprinkles), enter **delivery details**, then **checkout** with a live total and **async** order submission.

## Features

- **`NavigationStack`** flow: main form → **Delivery details** → **Checkout**.
- **`@Observable` `Order`** conforming to **`Codable`** for JSON POST to the sample API used in the project (`reqres.in`).
- **Delivery address persistence**: name, street, city, and zip are saved to **`UserDefaults`** as one **JSON-encoded** `Codable` snapshot (not `@AppStorage`), with **`didSet`** on each field and **`suppressAddressPersistence`** during `init()` so loading does not write back redundantly.
- **`hasValidAddress`**: non-empty, trimmed non-whitespace-only fields, and minimum length before enabling checkout navigation.
- **`CheckoutView`**: hero **`AsyncImage`**, currency-formatted **`Decimal`** total, **Place order** with `URLSession` upload and decoded response for the confirmation alert.

## Project layout

- `CupcakeCornerApp.swift` — app entry.
- `ContentView.swift` — type, quantity, special requests, link to delivery.
- `AddressView.swift` — address fields and navigation to checkout.
- `CheckoutView.swift` — total, place order, alert.
- `Order.swift` — model, cost calculation, address persistence helpers.

## Requirements

- **Xcode 15+** with Swift **5.9+** (SwiftUI, `@Observable`).
- **iOS** version as set in the Xcode project (match deployment target to your device or simulator).
- **Network** for checkout image URL and order POST.

## Open in Xcode

1. Open `CupcakeCorner.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).

## Learn more

Patterns: **`@Bindable`** for forms bound to `@Observable` models, **`Codable`** + `CodingKeys` with `@Observable` storage, **`Task` / `async`** networking, and **`UserDefaults`** persistence without coupling the whole model to `@AppStorage`.
