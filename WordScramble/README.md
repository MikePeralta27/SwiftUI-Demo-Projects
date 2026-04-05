# WordScramble

A SwiftUI **anagram** game: the app picks a random **root word** from `start.txt`, and you submit words that use only those letters. Each valid word is scored (word count), shown in a list with length badges, and **Restart** picks a new root word.

Uses `NavigationStack`, `List`, `TextField` with `onSubmit`, `UITextChecker` for English spell-checking, and alerts for validation errors (duplicate, impossible letters, unknown word, too short, same as root word).

## Requirements

- Xcode 15+ (SwiftUI)
- iOS version as set in the Xcode project (typically iOS 17+)

## Open in Xcode

1. Open `WordScramble.xcodeproj` in this folder.
2. Select a simulator or device and run (**⌘R**).

## Learn more

Follows the common **Word Scramble** / anagram tutorial pattern: load a word list from the bundle, validate with substring letter counts and `UITextChecker`.
