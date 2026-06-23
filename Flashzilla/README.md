# Flashzilla

SwiftUI **flashcard quiz** demo from **100 Days of SwiftUI**: study with a stacked deck, tap to reveal answers, swipe right for correct and left for wrong, and race a 100-second timer. Cards persist with **SwiftData**.

## Features

- **Stacked card deck** with the top card interactive; lower cards offset for depth.
- **Tap to flip** between prompt and answer (single combined label when VoiceOver is on).
- **Drag gestures** with green/red feedback: swipe right to mark correct, left to mark wrong.
- **Wrong answers return** to the back of the deck (`insert` at index 0) so you can try them again later.
- **100-second countdown** that pauses when the app moves to the background or the deck is empty.
- **Edit sheet** to add cards (prompt + answer) and swipe-to-delete from the library.
- **Accessibility** support: differentiate-without-color mode, VoiceOver labels/hints, and on-screen correct/wrong buttons when needed.
- **SwiftData persistence** via `@Model`, `@Query`, and `modelContext` — game play uses a temporary `@State` copy of the saved library.

## Project layout

- `FlashzillaApp.swift` — app entry point and `.modelContainer(for: Card.self)`.
- `Card.swift` — SwiftData `@Model` with stable `UUID`, prompt, and answer.
- `ContentView.swift` — game UI, timer, scene-phase handling, deck management, edit sheet.
- `CardView.swift` — individual card layout, drag gesture, tap-to-reveal, color feedback.
- `EditCards.swift` — add/delete cards in the persistent library.

## Requirements

- **Xcode 15+** with Swift **5.9+**.
- **iOS 17+** (project deployment target may be newer) for SwiftData and modern SwiftUI APIs used here.

## Open in Xcode

1. Open `Flashzilla.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).
3. Tap **+** to add flashcards, then swipe or use the accessibility buttons to play.
4. Swipe **right** (green) when you know the answer; swipe **left** (red) to send the card to the back of the deck.
5. Tap a card to reveal its answer before swiping.

## Learn more

Patterns: **SwiftData** (`@Model`, `@Query`, `modelContext.insert` / `delete`, `.modelContainer`), **`DragGesture`** with animated offset, **`Timer.publish`** and `onReceive`, **`scenePhase`** to pause gameplay, **`@Environment`** accessibility values, **`ForEach` with `Identifiable`**, stacked layout with `ZStack`, and separating **persistent library** data from **in-game deck** state.
