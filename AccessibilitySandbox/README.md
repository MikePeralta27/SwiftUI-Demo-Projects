# AccessibilitySandbox

SwiftUI **accessibility** sandbox from **100 Days of SwiftUI**: explore VoiceOver labels, hidden decorative images, adjustable actions, and combined accessibility elements.

## Features

- **`accessibilityAdjustableAction`** on a button to increment/decrement a numeric value with VoiceOver.
- **`accessibilityLabel`** on meaningful images (avatar, landscape photos).
- **`accessibilityHidden(true)`** on decorative photos that should not be read aloud.
- **`accessibilityElement(children: .combine)`** to merge related text into one VoiceOver element.

## Project layout

- `AccessibilitySandboxApp.swift` — app entry point.
- `ContentView.swift` — accessibility modifiers demo.
- `Assets.xcassets` — sample images for labeled and hidden content.

## Requirements

- **Xcode 15+** with Swift **5.9+**.
- **iOS 17+** (or project deployment target) for modern SwiftUI accessibility APIs.

## Open in Xcode

1. Open `AccessibilitySandbox.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).
3. Enable **VoiceOver** (Settings → Accessibility → VoiceOver, or Accessibility Inspector in Xcode) to hear the differences.

## Learn more

Patterns: **`accessibilityLabel`**, **`accessibilityHidden`**, **`accessibilityAdjustableAction`**, and **`accessibilityElement(children:)`** for richer VoiceOver experiences.
