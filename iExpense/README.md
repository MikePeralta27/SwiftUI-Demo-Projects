# iExpense

SwiftUI **expense tracker** with three categories—**Personal**, **Business**, and **Other**. Data is stored with **SwiftData** (`@Model`, `@Query`, `modelContext`). Add expenses via **navigation** to a form, use **Edit** and swipe to **delete** within each section, and choose **sort by name or amount** from the toolbar.

## Features

- **`ExpenseItem`** `@Model`: name, type, amount, stable `id`.
- **`iExpenseApp`**: `modelContainer(for: ExpenseItem.self)`.
- **`ContentView`**: `NavigationStack` with three **`ExpensesSection`** views (filtered with `#Predicate`), a **Sort** menu driving shared **`SortDescriptor`s**, **Add** pushes **`AddView`**, and **Edit** for list editing.
- **`ExpensesSection`**: `@Query` filtered by `type`, `ForEach` rows, **`onDelete`** with **`modelContext.delete`** wrapped in **`withAnimation`**.
- **`AddView`**: type picker, currency **`TextField`**, **`modelContext.insert`**, dismiss on save.

## Requirements

- **Xcode 15+** with Swift **5.9+**
- **iOS 17+** (or the project deployment target) for **SwiftData**

## Open in Xcode

1. Open `iExpense.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).

## Learn more

Patterns: **SwiftData** persistence, **`#Predicate`** with `@Query`, **`NavigationStack`** and `navigationDestination`, toolbar **sort** and **edit**, and **`modelContext`** insert/delete.
