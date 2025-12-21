Movie Search App 🎬

A Flutter application that searches and displays movies using a backend API.
The project follows Clean Architecture, uses BLoC for state management, GetIt for dependency injection, and Freezed for immutable models and states.

HOW TO RUN:
1. Install dependencies
flutter pub get

2. Generate code (Freezed & JSON serialization)
flutter pub run build_runner build --delete-conflicting-outputs

This step is required because generated files (*.g.dart, *.freezed.dart) are not committed.

3. Run the app
flutter run

Generated files (*.g.dart, *.freezed.dart) are intentionally ignored in .gitignore

No .apk, .ipa, or .app files are committed

No screenshots or zipped source files are included

The project is ready to run after executing the steps above


Features:

Search movies by text pattern
Fetch data from a remote backend (API)
Clean Architecture (data / domain / presentation layers)
BLoC (Business Logic Component)
Dependency Injection with GetIt
Freezed for states and models
Error handling and loading states

## Architecture

```text
lib/
├── core/
│   ├── di/
│   │   └── service_locator.dart
│   └── errors/
│       ├── failures.dart
│       └── utils/
│
├── features/
│   └── movie/
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── movie_remote_datasource.dart
│       │   │   └── movie_remote_datasource_impl.dart
│       │   └── models/
│       │       ├── movie_model.dart
│       │       ├── movie_model.freezed.dart
│       │       └── movie_model.g.dart
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   └── movie.dart
│       │   ├── repositories/
│       │   │   └── movie_repository.dart
│       │   └── usecases/
│       │       └── get_all_movies.dart
│       │
│       └── presentation/
│           ├── bloc/
│           │   ├── movie_bloc.dart
│           │   ├── movie_event.dart
│           │   └── movie_state.dart
│           │
│           ├── pages/
│           │   ├── home_page.dart
│           │   └── movie_details_page.dart
│           │
│           └── widgets/
│               └── movie_card.dart
│
└── main.dart





