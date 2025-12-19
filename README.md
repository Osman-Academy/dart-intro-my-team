# String Search by Pattern App

A Flutter application that demonstrates Clean Architecture, Dependency Injection, BLoC state management, and Freezed for immutable data modeling. The app retrieves user data from a REST API and allows real-time string pattern searching through user names.

## Features

- **Clean Architecture**: Separated into Presentation, Domain, and Data layers
- **Dependency Injection**: Using GetIt and Injectable for scalable DI
- **State Management**: BLoC pattern with Freezed for immutable states
- **Real-time Search**: Case-insensitive pattern matching on user names
- **Backend Integration**: Fetches data from JSONPlaceholder API
- **Modern UI**: Material Design with clean, academic styling

## Architecture

```
lib/
├── core/
│   └── di/
│       └── injection.dart          # Dependency injection setup
├── data/
│   ├── datasource/
│   │   └── user_remote_datasource.dart  # API communication
│   ├── models/
│   │   └── user_model.dart        # Data models with Freezed
│   └── repositories/
│       └── user_repository_impl.dart    # Repository implementation
├── domain/
│   ├── entities/
│   │   └── user.dart               # Business entities
│   ├── repositories/
│   │   └── user_repository.dart    # Repository interface
│   └── usecases/
│       └── search_users.dart       # Business logic
└── presentation/
    ├── bloc/
    │   ├── search_bloc.dart        # BLoC logic
    │   ├── search_event.dart       # Events
    │   └── search_state.dart       # States
    └── pages/
        └── home_page.dart          # Main UI
```

## Technologies Used

- **Flutter**: UI framework
- **Dio**: HTTP client for API calls
- **BLoC**: State management
- **Freezed**: Code generation for immutable classes
- **GetIt + Injectable**: Dependency injection
- **Clean Architecture**: Project structure

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Run `flutter pub run build_runner build` to generate code
5. Run `flutter run` to start the app

### API

The app uses [JSONPlaceholder](https://jsonplaceholder.typicode.com/users) for mock user data.

## Usage

1. Launch the app
2. Type in the search field to filter users by name
3. Results update in real-time as you type
4. View user names and emails in the list

## Project Structure Explanation

- **Presentation Layer**: Contains UI components and BLoC for state management
- **Domain Layer**: Contains business logic, entities, and use cases
- **Data Layer**: Handles data retrieval and mapping between API and domain models
- **Core Layer**: Contains shared utilities like dependency injection

## Code Generation

The project uses code generation for:
- Freezed classes (models, events, states)
- Injectable dependencies
- JSON serialization

Run `flutter pub run build_runner build` after making changes to annotated classes.

## Contributing

This is a final project submission. No external contributions accepted.
