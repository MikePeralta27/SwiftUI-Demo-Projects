# Edutainment

A SwiftUI **multiplication practice** game: choose a **times table** (2–12), how many questions you want (5, 10, 15, or 20), then answer prompts like `7 x 3`. The app shows **Correct** / **Wrong** feedback with light animation, tracks your **score**, and ends the round with a **Game Over** alert and **New Game** reset.

Uses `NavigationStack`, `Form`, `Stepper`, `Picker`, and a decimal-pad `TextField` with `onSubmit` to check answers against a generated question set.

## Requirements

- Xcode 15+ (SwiftUI)
- iOS version as set in the Xcode project (typically iOS 17+)

## Open in Xcode

1. Open `Edutainment.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).

## Learn more

Follows the common **Edutainment** / times-table quiz pattern: random multipliers, local state for score and round length, and regeneration when the table or question count changes.
