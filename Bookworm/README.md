# Bookworm

SwiftUI **reading log** demo from **100 Days of SwiftUI**: track books with title, author, genre, written review, star rating, and **date added**. Data persists with **SwiftData** (`@Model`, `@Query`, `modelContext`).

## Features

- **`Book`** `@Model` class: title, author, genre, review, rating, **`date`** (defaults to creation time).
- **`BookwormApp`**: `modelContainer(for: Book.self)` for on-disk persistence.
- **`ContentView`**: `NavigationStack`, `@Query` sorted by title then author, list rows with **`EmojiRatingView`** and navigation to detail; **1-star titles** use red foreground for quick scanning; swipe-to-delete; **Edit** mode; sheet to add a book.
- **`AddBookView`**: form with text fields, genre picker, **`TextEditor`** for review, **`RatingView`** (tap stars); **Add book** stays disabled until fields are non-empty, meet minimum length, and a rating is chosen; inserts new `Book` into the model context.
- **`DetailView`**: genre hero image from asset catalog, **formatted date added**, author and review, read-only star rating, toolbar delete with confirmation **`alert`**.
- **Genre images**: bundled assets for Fantasy, Horror, Kids, Mystery, Poetry, Romance, Thriller (match picker strings).

## Project layout

- `BookwormApp.swift` — app entry and SwiftData container.
- `Book.swift` — `@Model` definition.
- `ContentView.swift` — list, navigation, delete, add sheet.
- `AddBookView.swift` — create book form.
- `DetailView.swift` — book detail and delete.
- `RatingView.swift` / `EmojiRatingView.swift` — star and emoji rating UI.

## Requirements

- **Xcode 15+** with Swift **5.9+**.
- **iOS 17+** (or project deployment target) for **SwiftData** as used here.

## Open in Xcode

1. Open `Bookworm.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).

## Learn more

Patterns: **SwiftData** persistence, **`@Query`** in views, **`modelContext.insert`** / **`delete`**, **`NavigationLink(value:)`** with **`navigationDestination(for:)`**, and custom rating controls.
