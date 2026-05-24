# Instafilter

SwiftUI **photo filter** demo from **100 Days of SwiftUI**: import a photo with **PhotosPicker**, apply **Core Image** filters, tune parameters with sliders, and share the result.

## Features

- **PhotosPicker** import with `loadTransferable` and `CIImage` pipeline.
- **Core Image** filters via `CIFilter` built-ins: Crystallize, Edges, Gaussian Blur, Pixellate, Sepia Tone, Unsharp Mask, Vignette, Box Blur, Bump Distortion Linear, and Bloom.
- **Dynamic sliders** for intensity, radius, and scale based on each filter’s `inputKeys`.
- **ShareLink** to export the processed SwiftUI `Image`.
- **`@AppStorage("filterCount")`** to track filter changes across launches and trigger **`requestReview()`** after three filter selections.

## Project layout

- `InstafilterApp.swift` — app entry point.
- `ContentView.swift` — picker UI, filter dialog, Core Image processing, and sharing.

## Requirements

- **Xcode 15+** with Swift **5.9+**.
- **iOS 17+** (or project deployment target) for PhotosPicker and modern SwiftUI APIs used here.
- Photo library access when picking images on device.

## Open in Xcode

1. Open `Instafilter.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).
3. Tap the placeholder to import a photo, choose **Change Filter**, then adjust sliders as needed.

## Learn more

Patterns: **Core Image** (`CIContext`, `CIFilter`, `kCIInputImageKey`), **PhotosUI**, conditional UI from filter `inputKeys`, **`ShareLink`**, **`@AppStorage`**, and **StoreKit** review requests.
