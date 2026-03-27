# Unit-Converter

A small **SwiftUI** demo app that converts values across **temperature**, **length**, **time**, and **volume**. Pick a category with the segmented control, choose input and output units, enter a value, and read the converted result. Conversions go through a single base unit per category (e.g. Celsius, meters, seconds, liters); volume uses **US liquid** cup / pint / gallon definitions.

## Run

1. Open **`Unit-Converter.xcodeproj`** in this folder.
2. Select a simulator or device, then **⌘R**.

## Demo video

https://github.com/user-attachments/assets/1cff1314-3e32-4b20-a233-45d80f561774


| Option | What to do |
|--------|------------|
| **File in repo** | Save the file as [`docs/demo.mp4`](docs/demo.mp4) (the `docs` folder is in this project). In this section, add a markdown link, e.g. `[Watch the demo](docs/demo.mp4)` — on GitHub, opening the file shows an inline player. |
| **External host** | Link to **YouTube**, **Vimeo**, or any public URL the same way: `[Title](https://…)`. |

**Your link:** _(add a markdown link here, e.g. `[Watch the demo](docs/demo.mp4)` after you add the file, or paste a YouTube URL.)_

## Documentation

Use this section for notes, learning goals, or links.

- **Features:** segmented unit type, input/output pickers, formatted numeric entry (if enabled), defaults when switching category.
- **Ideas to document:** formulas, locale choices, or known limitations (e.g. US vs imperial gallons).

**Your notes:**

> _Add bullets or links here._

## Requirements

- **Xcode 15+** recommended  
- **iOS** deployment target as set in the Xcode project (SwiftUI / `NavigationStack`)
