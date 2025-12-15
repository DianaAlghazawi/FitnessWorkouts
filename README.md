# Offline Fitness Workouts

A fully offline, production-ready Flutter fitness application with zero permissions, fully compliant with Google Play Console 2025-2026 policies.

## Features

- ✅ **100% Offline** - No internet connection required
- ✅ **Zero Permissions** - No camera, contacts, location, storage, or any other permissions
- ✅ **No Ads** - Clean, ad-free experience
- ✅ **No Login Required** - Start using immediately
- ✅ **Material 3 Design** - Modern, beautiful UI
- ✅ **Accessibility Friendly** - Screen reader support and proper semantics
- ✅ **Fully Functional** - All features work without network

## Workout Categories

- Full Body Workouts
- Abs & Core
- Arms & Shoulders
- Legs & Glutes
- Stretching & Flexibility

## Features

### Workout Management
- Browse workouts by category
- Filter by difficulty (Easy, Medium, Hard)
- Search workouts
- View detailed workout instructions
- Step-by-step workout guidance

### Favorites
- Save favorite workouts
- Quick access to preferred workouts

### Progress Tracking
- Track completed workouts
- View total minutes trained
- Monitor calories burned
- Workout history

### Workout Timer
- Built-in timer for workouts
- Step-by-step exercise guidance
- Progress tracking during workout
- Automatic completion logging

### Settings
- Light/Dark theme support
- System theme detection
- Privacy policy
- App information

## Architecture

The app follows Clean Architecture principles with MVVM pattern:

```
lib/
├── core/           # Core utilities, database, DI, theme
├── data/           # Data sources, repositories, models
├── domain/         # Entities, repositories (interfaces), use cases
└── presentation/   # UI screens, widgets, state management
```

## State Management

Uses Riverpod for state management and dependency injection.

## Database

Uses SQLite (sqflite) for local data storage:
- Workouts table
- Favorites table
- History table

## Getting Started

1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter run`

## Requirements

- Flutter 3.x
- Dart 3.0+
- No external dependencies beyond Flutter SDK

## Google Play Compliance

- ✅ No sensitive permissions
- ✅ No network requests
- ✅ All screens functional
- ✅ Accessibility labels
- ✅ Material 3 design
- ✅ No crashes on empty states
- ✅ Fully offline
- ✅ Privacy policy included

## Privacy

This app collects zero data. All information is stored locally on your device. See the Privacy Policy in the app for more details.

## License

This project is open source and available for use.
