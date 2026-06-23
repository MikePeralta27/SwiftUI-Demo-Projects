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
| [**Edutainment**](Edutainment/) | Times-table quiz: pick table 2–12 and question count (5–20); unique prompts, score tracking, animated feedback, and Game Over with New Game. |
| [**iExpense**](iExpense/) | Expense log with **SwiftData**: three categories via filtered `@Query`, navigation add form, toolbar sort (name/amount) and edit, swipe delete. |
| [**SwiftDataProject**](SwiftDataProject/) | SwiftData users and jobs: `@Model`, cascade relationship, `@Query` with `#Predicate`, sample list UI. |
| [**WordScramble**](WordScramble/) | Anagram game: form valid English words from a random root word’s letters; score, restart, and spell-check with UITextChecker. |
| [**Moonshot**](Moonshot/) | Apollo program browser: bundled JSON for missions and astronauts, grid/list layout toggle, mission detail with crew strip and astronaut profiles. |
| [**habit-tracker**](habit-tracker/) | Habit list: add habits from a sheet, list with typed navigation by `UUID`, detail with completion count and JSON persistence in `UserDefaults`. |
| [**CupcakeCorner**](CupcakeCorner/) | Cupcake order flow: picker, stepper, special requests, delivery form with validation, JSON `UserDefaults` persistence for address, checkout with `AsyncImage`, currency total, and async POST with `Codable` `Order`. |
| [**Bookworm**](Bookworm/) | Reading log: SwiftData `@Model` books, sorted list with emoji ratings, add form with stars and review, detail with genre art, swipe delete and confirmation. |
| [**Instafilter**](Instafilter/) | Photo filters: **PhotosPicker** import, **Core Image** effects with intensity/radius/scale sliders, filter picker dialog, **ShareLink**, and review prompt via **`@AppStorage`**. |
| [**BucketList**](BucketList/) | Map bucket list: tap-to-add pins, double-tap to edit, **Face ID** unlock, map style picker, JSON persistence with file protection, and Wikipedia nearby places in the edit sheet. |
| [**AccessibilitySandbox**](AccessibilitySandbox/) | Accessibility lab: VoiceOver labels, hidden decorative images, adjustable actions, and combined accessibility elements. |
| [**FaceRecall**](FaceRecall/) | Conference contacts: **PhotosPicker** import, immediate naming alert, SwiftData persistence, sorted list, detail view with **MapKit** pin, optional **Core Location** at save time, and swipe delete. |
| [**HotProspects**](HotProspects/) | Conference networking: **QR scan** to save contacts, SwiftData tabs (everyone/contacted/uncontacted), edit form, sort menu, swipe actions, local notifications, bulk delete, and **Me** tab with QR generation and **ShareLink**. |

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
├── Edutainment/
│   ├── README.md
│   └── Edutainment.xcodeproj
├── iExpense/
│   ├── README.md
│   └── iExpense.xcodeproj
├── SwiftDataProject/
│   ├── README.md
│   └── SwiftDataProject.xcodeproj
├── WordScramble/
│   ├── README.md
│   └── WordScramble.xcodeproj
├── Moonshot/
│   ├── README.md
│   └── Moonshot.xcodeproj
├── habit-tracker/
│   ├── README.md
│   └── habit-tracker.xcodeproj
├── CupcakeCorner/
│   ├── README.md
│   └── CupcakeCorner.xcodeproj
├── Bookworm/
│   ├── README.md
│   └── Bookworm.xcodeproj
├── Instafilter/
│   ├── README.md
│   └── Instafilter.xcodeproj
├── BucketList/
│   ├── README.md
│   └── BucketList.xcodeproj
├── AccessibilitySandbox/
│   ├── README.md
│   └── AccessibilitySandbox.xcodeproj
├── FaceRecall/
│   ├── README.md
│   └── FaceRecall.xcodeproj
├── HotProspects/
│   ├── README.md
│   └── HotProspects.xcodeproj
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
