# Moonshot

A SwiftUI **Apollo program** browser. Missions and crew are loaded from bundled JSON (`missions.json`, `astronauts.json`). Browse missions in a **grid or list** (toolbar toggle), open **mission detail** with patch art, launch date, long-form narrative, and a **horizontal crew strip**; tap a crew member for their **astronaut profile** (portrait and biography).

## Features

- **NavigationStack** with `NavigationLink` drill-down from the mission catalog to `MissionView`, then to `AstronautView`.
- **Grid / list** toggle on the home screen: `LazyVGrid` with adaptive columns vs `LazyVStack`, switched from the toolbar (SF Symbol `square.grid.2x2` / `list.dash`).
- **Codable** models: `Mission` (id, optional `launchDate`, crew roles, description) and `Astronaut` (id, name, description); crew ids in JSON resolve to astronauts via a dictionary keyed by id.
- **Bundle decoding**: generic `Bundle.decode(_:)` with `JSONDecoder`, `DateFormatter` format `y-MM-dd`, and explicit decoding error messages.
- **Theming**: dark background for the app shell, mission detail on a lighter panel; custom colors via `ShapeStyle` extensions (`darkBackground`, `lightBackground`).
- **Assets**: Apollo patch images (`apollo1` … `apollo17`) and astronaut portraits in **Asset Catalog**; `preferredColorScheme(.dark)` on the root experience.

## Project layout

```
Moonshot/
├── README.md                 ← You are here
├── Moonshot.xcodeproj
└── Moonshot/
    ├── MoonshotApp.swift
    ├── ContentView.swift      ← Mission grid/list + navigation
    ├── Mission.swift
    ├── MissionView.swift      ← Detail, crew scroller
    ├── Astronaut.swift
    ├── AstronautView.swift
    ├── Bundle-Decodable.swift
    ├── Color-Theme.swift
    ├── astronauts.json
    └── missions.json
```

The Xcode project uses a **file system synchronized** group for the `Moonshot/` app folder (Xcode 16+), so new Swift files and JSON under that folder are picked up automatically.

## Requirements

- **Xcode 26+** (project last upgraded with Xcode 26.4; file system synchronized groups)
- **iOS 26.4** deployment target as set in the Xcode project
- **Swift 5**

## Open in Xcode

1. Open `Moonshot.xcodeproj` in this folder.
2. Select a simulator or device on **iOS 26.4** (or compatible) and run (**⌘R**).

## Data

| File | Contents |
|------|-----------|
| `Moonshot/astronauts.json` | Astronaut `id`, `name`, and short `description` (biography). |
| `Moonshot/missions.json` | Mission `id`, optional `launchDate` (`y-MM-dd`), `crew` array (`name` matching astronaut id, `role`), and mission `description`. |

Patch image names follow `apollo{missionId}`; portrait image names match astronaut `id`.

## Learn more

Follows the common **Moonshot** / Apollo tutorial pattern: `Codable` models, generic bundle decoding, `NavigationLink`-driven drill-down, and JSON-driven content.
