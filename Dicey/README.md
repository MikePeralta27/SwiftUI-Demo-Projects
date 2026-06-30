# Dicey

SwiftUI **dice roller** demo from **100 Days of SwiftUI**: customize how many dice to roll and their type (D4–D100), watch values flicker before settling, see the total, and browse a persistent history of past rolls.

## Features

- **Customizable rolls** — stepper for 1–10 dice; picker for 4-, 6-, 8-, 10-, 12-, 20-, and 100-sided dice.
- **Roll animation** — `Timer` flickers random values for ~15 ticks before showing the final result.
- **Total display** — sum shown when rolling more than one die.
- **Wrapping dice grid** — up to 5 dice per row via `LazyVGrid` (10 dice layout: 5 + 5).
- **Haptic feedback** — medium impact when a roll completes.
- **Roll history** — previous rolls with date, dice type, individual values, and total.
- **SwiftData persistence** — `@Model` `RollRecord`, `@Query` history, `modelContext.insert` on each roll.
- **Accessibility** — per-die labels, `.updatesFrequently` during animation, roll button hint, VoiceOver announcement on settle, combined history row labels.
- **Coordinator + subviews** — `ContentView` owns state and side effects; presentational views receive data via `let`, `@Binding`, or closures.

## Project layout

- `DiceyApp.swift` — app entry point and `.modelContainer(for: RollRecord.self)`.
- `RollRecord.swift` — SwiftData `@Model` (date, dice count, sides, results, total).
- `ContentView.swift` — screen coordinator: `@Query`, roll logic, Timer, haptics, composition.
- `DiceSettingsView.swift` — stepper and dice-type picker (`@Binding`).
- `DiceDisplayView.swift` — dice grid, total, roll button.
- `RollHistoryView.swift` — history section with empty state.
- `RollHistoryRowView.swift` — single history card and accessibility label.

## Requirements

- **Xcode 15+** with Swift **5.9+**.
- **iOS 17+** (or project deployment target) for **SwiftData** and modern SwiftUI APIs used here.

## Open in Xcode

1. Open `Dicey.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).
3. Adjust dice count and type, tap **Roll**, then scroll down to see saved history.
4. Relaunch the app to confirm history persists.

## Learn more

Patterns: **SwiftData** (`@Model`, `@Query`, `modelContainer`), **Timer** for bounded animation, separating **display state** from **persisted results**, **`LazyVGrid`** for wrapping layouts, **`UIImpactFeedbackGenerator`**, **`UIAccessibility.post`**, and **coordinator vs presentational subviews** (`@Binding`, `let` props, action closures).
