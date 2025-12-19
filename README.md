# Movie Tracker App

Flutter application for searching and saving movies using the TMDb API.

## Project Requirements

Clean Architecture  
Dependency Injection (GetIt + Injectable)  
BLoC для State Management  
Freezed for code generation 
String Search by Pattern  
Backend Integration (TMDb API)

## Setup Instructions

### 1. Get an API Key

1. Sign up on [TMDb](https://www.themoviedb.org/)
2. Go to Settings → API
3. Create a new API Key (select "Developer")
4. Copy your API Key

### 2. Project Setup

```bash
# Project Setup
git clone <your-repo-url>
cd movie_tracker

# Install dependencies
flutter pub get

# Add your API Key
# Open lib/core/utils/constants.dart
# Replace 'YOUR_API_KEY_HERE' with your key
```

### 3. Code Generation

```bash
# Generate all necessary files
flutter pub run build_runner build --delete-conflicting-outputs

# Or use watch mode for automatic generation
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 4. Run the App

```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   ├── di/           # Dependency Injection
│   ├── error/        # Failures & Exceptions
│   ├── network/      # API Client
│   └── utils/        # Constants
├── features/
│   └── movies/
│       ├── data/
│       │   ├── datasources/   # Remote & Local Data Sources
│       │   ├── models/        # Data Models
│       │   └── repositories/  # Repository Implementation
│       ├── domain/
│       │   ├── entities/      # Business Entities
│       │   ├── repositories/  # Repository Contracts
│       │   └── usecases/      # Use Cases
│       └── presentation/
│           ├── bloc/          # BLoC State Management
│           ├── pages/         # UI Pages
│           └── widgets/       # Reusable Widgets
└── main.dart
```

## Key Features

- **Search movies** by title (String Search Pattern)
- **Popular movies** on app launch
- **Save movies** locally (SharedPreferences)
- **Movie rating and information** about films
- **Infinite scroll** (infinite scroll)
- **Adaptive design** (Material 3)

## Architecture

### Clean Architecture Layers:

1. **Presentation Layer** (UI + BLoC)
   - Pages, Widgets, BLoC

2. **Domain Layer** (Business Logic)
   - Entities, Use Cases, Repository Interfaces

3. **Data Layer** (Data Handling)
   - Models, Data Sources, Repository Implementation

### Data Flow:

```
UI → BLoC → UseCase → Repository → DataSource → API/Local Storage
```

## Main Libraries

- `flutter_bloc` - State Management
- `get_it` + `injectable` - Dependency Injection
- `freezed` - Code Generation
- `dio` + `retrofit` - HTTP Client
- `shared_preferences` - Local Storage
- `dartz` - Functional Programming (Either)
- `cached_network_image` - Image Caching

## Code Generation Commands

```bash
# Initial generation (will remove conflicting files)
flutter pub run build_runner build --delete-conflicting-outputs

# Automatic generation on changes
flutter pub run build_runner watch

# Clear cache before generation
flutter pub run build_runner clean
```

## Important Checks

### Clean Architecture
- Separation into layers: presentation, domain, data
- Dependencies directed inward (from data to domain)
- Domain layer does not depend on external libraries

### Dependency Injection
- Using GetIt as Service Locator
- Injectable for automatic registration
- All dependencies injected via constructors

### BLoC Pattern
- Clean separation of Events, States, BLoC
- Freezed for immutable states/events
- BLoC is unaware of UI

### Freezed Annotations
- All models use @freezed
- Immutable data classes
- Automatic generation of copyWith, ==, hashCode

### String Search by Pattern
- Search function in `SearchMovies` use case
- Validation of search query
- Handling empty strings

## Troubleshooting

### Code generation errors
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### API Issues
- Make sure the API key is correct in `constants.dart`
- Ensure an internet connection
- Check API limits (TMDb gives 1000 requests/day for free)

### Compilation Errors
- Ensure all generated files exist (.g.dart, .freezed.dart)
- Make sure all imports are correct
- Run `flutter pub get` again

## Author

Bermet Temirbaeva  - Final Project для Mobile Development

## License

Project created for educational purposes.

---
