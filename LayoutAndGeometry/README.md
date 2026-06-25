# LayoutAndGeometry

SwiftUI **scroll effects** demo from **100 Days of SwiftUI**: a vertical list of rows that respond to their position inside a `ScrollView` using nested `GeometryReader` views and a named coordinate space.

## Features

- **Top fade** — rows within ~200pt of the scroll view top fade to 0 opacity.
- **Position-based scale** — rows near the top scale down to 50%; rows near the bottom render at full size.
- **Scroll-driven color** — row backgrounds use `Color(hue:saturation:brightness:)` with hue mapped to vertical position.
- **3D rotation** — each row tilts on the Y axis based on its distance from the vertical center of the screen.

## Project layout

- `LayoutAndGeometryApp.swift` — app entry point.
- `ContentView.swift` — `ScrollView`, per-row `GeometryReader`, fade/scale/color helpers, and `rotation3DEffect`.

## Requirements

- **Xcode 15+** with Swift **5.9+**.
- **iOS 17+** (or the deployment target set in the Xcode project).

## Open in Xcode

1. Open `LayoutAndGeometry.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).
3. Scroll the list and watch rows fade, scale, change color, and rotate as they move.

## Learn more

Patterns: **`GeometryReader`**, **named coordinate spaces** (`.coordinateSpace(name:)`), **`frame(in:)`** for scroll-relative layout, **`scaleEffect`**, **`opacity`**, **`rotation3DEffect`**, and mapping continuous position values to visual properties.
