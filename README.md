# SwiftUI-Demo-Projects

A monorepo of small **SwiftUI** sample apps—each folder is a standalone Xcode project you can open and run on its own.

## Projects

| Project | Description |
| -------- | ----------- |
| [**WeSplit**](WeSplit/) | Bill splitter: check amount, party size, tip %, total and per-person share with locale-aware currency. |
| [**Unit-Converter**](Unit-Converter/) | Multi-category unit converter (temperature, length, time, volume) in a single form-based SwiftUI screen. |
| [**GuessTheFlag**](GuessTheFlag/) | Flag quiz: pick the correct flag for the named country; score, alerts, and shuffled rounds. |
| [**RockPaperAndScissors**](RockPaperAndScissors/) | RPS challenge: random opponent and win/lose/tie goal; 10 rounds, score, alerts, restart. |
| [**BetterRest**](BetterRest/) | Sleep helper: Core ML predicts sleep from wake time, sleep goal, and coffee; live-updating recommended bedtime. |

## Repository layout

```
SwiftUI-Demo-Projects/
├── README.md                 ← You are here
├── WeSplit/
│   ├── README.md
│   └── WeSplit.xcodeproj
├── Unit-Converter/
│   ├── README.md
│   └── Unit-Converter.xcodeproj
├── GuessTheFlag/
│   ├── README.md
│   └── GuessTheFlag.xcodeproj
├── RockPaperAndScissors/
│   ├── README.md
│   └── RockPaperAndScissors.xcodeproj
├── BetterRest/
│   ├── README.md
│   └── BetterRest.xcodeproj
└── …                         ← More demos added over time
```

## How to run a project

1. Open the `.xcodeproj` inside the project folder (e.g. `WeSplit/WeSplit.xcodeproj`).
2. Choose a run destination (simulator or device).
3. Press **⌘R** to build and run.

## Requirements

Individual apps may target different iOS versions; see each project’s README. Generally **Xcode 15+** and **Swift 5.9+** are expected.

## Contributing

Add new demos as new top-level folders with their own Xcode project and a **README.md** that explains what the app does and how to open it. Update the table in this file so the monorepo index stays current.
