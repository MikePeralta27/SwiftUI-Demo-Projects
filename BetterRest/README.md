# BetterRest

A SwiftUI demo that estimates an ideal **bedtime** from a **Core ML** regression model (`SleepCalculator`). You pick a wake-up time, desired hours of sleep, and daily coffee cups; the app shows a **recommended bedtime** in large type and updates it automatically whenever inputs change—no separate “calculate” button.

Uses `NavigationStack`, `Form`, `DatePicker`, `Stepper`, `Picker`, **Core ML** predictions, and `onAppear` / `onChange` to keep the UI in sync with the model.

## Requirements

- Xcode 15+ (SwiftUI, Core ML)
- iOS 17+ (uses the two-parameter `onChange` overload; adjust if you lower the deployment target)

## Open in Xcode

1. Open `BetterRest.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).

## Learn more

Follows the common “BetterRest” / sleep calculator tutorial pattern: train or bundle a regression model, then call `prediction(wake:estimatedSleep:coffee:)` and derive bedtime from `wakeUp - actualSleep`.
