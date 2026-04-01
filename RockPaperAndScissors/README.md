# RockPaperAndScissors

A **SwiftUI** take on the *100 Days of SwiftUI* rock–paper–scissors brain-teaser: each round the app picks a random **opponent move** (Rock, Paper, or Scissors) and a random **goal**—you must **Win**, **Lose**, or **Tie** against that move. Tap your choice; if your actual outcome matches the goal, your score goes up. Play **10 rounds**, then a **Game over** summary appears; **Restart** resets the score and starts a fresh game.

## Run

1. Open **`RockPaperAndScissors.xcodeproj`** in this folder.
2. Choose a simulator or device, then **⌘R**.

## Rules (standard RPS)

Rock beats scissors, scissors beats paper, paper beats rock; same move is a tie.

## What’s in the project

- **Model:** `Move` and `RoundOutcome` enums, plus logic that maps your pick vs the opponent to win / lose / tie.
- **UI:** Gradient background, material card, round indicator, result alert with **Continue**, game-over alert with **Restart**.
- **Flow:** `startRound()` randomizes opponent + goal after each continue; buttons are disabled while the result alert is visible.

## Requirements

- **Xcode 15+** recommended; deployment target as set in the Xcode project.
