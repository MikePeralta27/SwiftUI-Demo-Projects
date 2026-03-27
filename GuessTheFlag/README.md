# GuessTheFlag

A **SwiftUI** quiz game in the style of *100 Days of SwiftUI* / Paul Hudson’s “Guess the Flag” project: the app shows a **country name** and three **flag** buttons; tap the correct flag to earn a point. A **radial gradient** background, **material** card, and an **alert** with **Continue** drive the loop (shuffle countries and pick a new correct answer each round).

## Run

1. Open **`GuessTheFlag.xcodeproj`** in this folder.
2. Choose a simulator or device, then **⌘R**.

## What’s in the project

- **State:** shuffled country list, random `correctAnswer` index (0…2), running **score**, alert visibility.
- **UI:** `ZStack` + `VStack`, `Image` assets for each flag (capsule clip + shadow), score label.
- **Assets:** Flag images for Estonia, France, Germany, Ireland, Italy, Monaco, Nigeria, Poland, Spain, UK, Ukraine, and US (all included in the asset catalog).

## Notes

- Wrong answers do not decrease the score (tutorial-style behavior).
- **Accessibility:** For a production app you’d add accessibility labels on flag buttons and consider `VoiceOver` hints.

## Requirements

- **Xcode 15+** recommended; deployment target as set in the Xcode project.
