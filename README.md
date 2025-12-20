# Movie Search App

A Flutter application demonstrating Clean Architecture, BLoC pattern, Dependency Injection, and Freezed code generation for searching and browsing movies.

## Project Requirements

This project fulfills the following requirements:

-  **Clean Architecture** - Separation into Domain, Data, and Presentation layers
-  **Dependency Injection (DI)** - Using GetIt and Injectable
-  **BLoC Pattern** - State management with flutter_bloc
-  **Freezed Annotations** - Immutable data classes and union types
-  **Backend Integration** - Connected to The Movie Database (TMDB) API
-  **String Search by Pattern** - Real-time movie search functionality

## Architecture

### Clean Architecture Layers

```
lib/
├── core/                           # Core utilities and base classes
│   ├── error/                      # Error handling
│   │   ├── failures.dart           # Domain failures
│   │   └── exceptions.dart         # Data exceptions
│   ├── network/                    # Network configuration
│   │   └── api_client.dart         # Retrofit API client
│   └── usecases/                   # Base use case
│       └── usecase.dart
│
├── features/movies/
│   ├── domain/                     # Business Logic Layer
│   │   ├── entities/               # Pure business objects
│   │   │   └── movie.dart
│   │   ├── repositories/           # Abstract interfaces
│   │   │   └── movie_repository.dart
│   │   └── usecases/               # Business operations
│   │       └── search_movies.dart
│   │
│   ├── data/                       # Data Layer
│   │   ├── models/                 # Data transfer objects
│   │   │   └── movie_model.dart    # With Freezed
│   │   ├── datasources/            # API data sources
│   │   │   └── movie_remote_datasource.dart
│   │   └── repositories/           # Repository implementations
│   │       └── movie_repository_impl.dart
│   │
│   └── presentation/               # Presentation Layer
│       ├── bloc/                   # BLoC state management
│       │   ├── movie_search_bloc.dart
│       │   ├── movie_search_event.dart
│       │   └── movie_search_state.dart
│       ├── pages/                  # UI screens
│       │   └── movie_search_page.dart
│       └── widgets/                # Reusable components
│           └── movie_card.dart
│
├── injection.dart                  # Dependency injection setup
└── main.dart                       # App entry point
```

## Key Technologies

- **Flutter SDK** - Cross-platform UI framework
- **flutter_bloc** - State management
- **get_it** - Service locator
- **injectable** - Code generation for DI
- **freezed** - Immutable classes and unions
- **retrofit** - Type-safe HTTP client
- **dio** - HTTP networking
- **dartz** - Functional programming (Either type)
- **cached_network_image** - Image caching

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- TMDB API Key (optional, demo key included)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd movie_search_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate code:
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Run the app:
```bash
# On Chrome/Edge
flutter run -d chrome

# On Windows (requires Developer Mode enabled)
flutter run -d windows
```

## Configuration

### API Key Setup (Optional)

The app uses a demo TMDB API key by default. For production use:

1. Get your API key from [TMDB](https://www.themoviedb.org/settings/api)
2. Replace the key in `lib/features/movies/data/datasources/movie_remote_datasource.dart`:

```dart
static const String apiKey = 'YOUR_API_KEY_HERE';
```

## Features

- **Popular Movies** - Displays trending movies on app launch
- **Real-time Search** - Search movies as you type
- **Movie Details** - Tap any movie to view full details
- **Error Handling** - Graceful error messages with retry option
- **Responsive UI** - Dark theme with modern design
- **Image Caching** - Efficient image loading and caching

## Design Patterns

### Clean Architecture
- **Domain Layer**: Contains business logic, independent of frameworks
- **Data Layer**: Implements domain interfaces, handles external data
- **Presentation Layer**: UI and state management

### BLoC Pattern
- **Events**: User actions (SearchMovies, LoadPopularMovies, ClearSearch)
- **States**: UI states (Initial, Loading, Loaded, Error)
- **BLoC**: Business logic component managing state transitions

### Dependency Injection
- **@injectable**: Auto-generates dependency registration
- **@lazySingleton**: Single instance throughout app lifecycle
- **GetIt**: Service locator for dependency resolution

### Either Pattern (Dartz)
- **Left**: Represents failure/error
- **Right**: Represents success/data
- Enables functional error handling

## Code Generation

Generated files (excluded from version control):
- `*.g.dart` - JSON serialization
- `*.freezed.dart` - Freezed classes
- `*.config.dart` - Dependency injection

To regenerate:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Project Structure Principles

- **Separation of Concerns**: Each layer has a single responsibility
- **Dependency Rule**: Dependencies point inward (Presentation → Domain ← Data)
- **Interface Segregation**: Domain defines interfaces, Data implements them
- **Single Responsibility**: Each class has one reason to change
- **Open/Closed**: Open for extension, closed for modification

## Contributing

This is a student project demonstrating Flutter best practices and architectural patterns.

## License

This project is created for educational purposes.

## Author

Adilbekov Nursultan COMSE-23 Final Project

## Acknowledgments

- [The Movie Database (TMDB)](https://www.themoviedb.org/) for providing the API
- Flutter community for excellent packages and documentation
- Clean Architecture principles by Robert C. Martin
