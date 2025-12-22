# Book Finder

A modern, feature-rich Flutter application for discovering, organizing, and managing books using the Google Books API.

## Features

### Smart Book Search
- **Advanced Search**: Search by title, author, or subject
- **Real-time Updates**: Debounced search with auto-suggestions
- **Category Filtering**: Filter books by Fiction, Science, History, Art, and more
- **Rich Book Details**: View comprehensive information including ratings, publication dates, and descriptions

### Favorites Management
- **Quick Add/Remove**: One-tap favorite management from any screen
- **Persistent Storage**: Favorites are maintained throughout the app session
- **Real-time Sync**: Instant updates across all screens

### Custom Categories
- **Organize Your Library**: Create custom categories to organize your books
- **Default Collections**: Pre-built "Want to Read", "Currently Reading", and "Finished" categories
- **Multi-Category Support**: Add books to multiple categories simultaneously
- **Easy Management**: Delete custom categories with confirmation dialogs

### Modern UI/UX
- **Material Design**: Clean, intuitive interface following Material Design guidelines
- **Gradient Themes**: Beautiful indigo color scheme with gradient effects
- **Responsive Layout**: Optimized for various screen sizes
- **Smooth Animations**: Polished transitions and interactions
- **Empty States**: Helpful messages when no content is available

## Architecture

### Clean Architecture Pattern
The app follows Clean Architecture principles with clear separation of concerns:

```
lib/
├── bloc/
│   ├── book/
│   │   ├── book_bloc.dart
│   │   ├── book_event.dart
│   │   └── book_state.dart
│   └── category/
│       ├── category_bloc.dart
│       ├── category_event.dart
│       └── category_state.dart
├── models/
│   ├── book/
│   │   ├── book.dart
│   │   └── book_dto.dart
│   └── category/
│       ├── category.dart
│       └── category_dto.dart
├── repositories/
│   ├── repository_book.dart
│   ├── repository_book_remote.dart
│   ├── repository_category.dart
│   └── repository_category_local.dart
├── usecases/
│   ├── book_usecase.dart
│   └── category_usecase.dart
├── pages/
│   ├── home.dart
│   ├── detail.dart
│   └── favorites.dart
└── config/di/
    └── service_locator.dart
```

### Design Patterns Used

#### 1. **BLoC Pattern (Business Logic Component)**
- Separates business logic from UI
- Provides reactive state management
- Ensures unidirectional data flow
- Enables easy testing

```dart
// Example: BookBloc handles all book-related events
context.read<BookBloc>().add(BookSearchEvent(query: "flutter"));
```

#### 2. **Repository Pattern**
- Abstracts data sources
- Provides clean API for data access
- Allows easy switching between data sources
- Simplifies testing with mock implementations

```dart
abstract class RepositoryBook {
  Future<List<Book>> search(BookDto bookDto);
  Future<Book> view(BookDto bookDto);
}
```

#### 3. **Dependency Injection**
- Uses GetIt for service location
- Singleton pattern for shared instances
- Loose coupling between components

```dart
setupLocator() {
  sl.registerSingleton<RepositoryBook>(RepositoryBookRemote());
  sl.registerSingleton<BookUsecase>(BookUsecase(...));
}
```

#### 4. **DTO Pattern (Data Transfer Object)**
- Separates API data structure from domain models
- Provides flexibility for API changes
- Validates and transforms data

## Getting Started

### Prerequisites
- Flutter SDK (3.9.2)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/Osman-Academy/dart-intro-my-team.git
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run code generation** (for Freezed models)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Run the app**
```bash
flutter run
```

## Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  dio: ^5.3.3
  get_it: ^7.6.4
  freezed_annotation: ^2.4.1

dev_dependencies:
  build_runner: ^2.4.6
  freezed: ^2.4.5
  json_serializable: ^6.7.1
```

### Key Libraries Explained

- **flutter_bloc**: Implements the BLoC pattern for predictable state management
- **get_it**: Provides dependency injection and service location
- **dio**: Modern HTTP client with interceptors and error handling
- **freezed**: Generates immutable models with copyWith, equality, and serialization

## API Integration

### Google Books API
The app uses the [Google Books API](https://developers.google.com/books) to fetch book data.

**Endpoints Used:**
- `GET /volumes?q={query}` - Search books
- `GET /volumes/{volumeId}` - Get book details

## Key Features Implementation

### 1. Debounced Search
Prevents excessive API calls during typing:

```dart
Timer? _debounce;

void _onSearchChanged() {
  if (_debounce?.isActive ?? false) _debounce!.cancel();
  _debounce = Timer(const Duration(milliseconds: 800), () {
    _performSearch();
  });
}
```

### 2. State Preservation
Maintains search results when navigating between screens:

```dart
BookState? _previousSearchState;

on<BookSearchEvent>((event, emit) async {
  final newState = BookStateSuccess(books: booksWithFavorites);
  _previousSearchState = newState; // Save state
  emit(newState);
});
```

### 3. HTML Cleaning
Removes HTML tags from book descriptions:

```dart
String _cleanHtmlTags(String htmlString) {
  return htmlString
      .replaceAll(RegExp(r'<br\s*/?>'), '\n')
      .replaceAll(RegExp(r'<[^>]+>'), '')
      .trim();
}
```

### 4. Real-time Synchronization
Updates UI across all screens when favorites change:

```dart
on<BookToggleFavoriteEvent>((event, emit) {
  usecase.toggleFavorite(event.book);
  // Updates both current and saved states
  if (_previousSearchState != null) {
    // Update saved search state
  }
});
```

## UI Components

### Custom Widgets
- **Book Card**: Reusable card displaying book information
- **Category Chip**: Interactive chips for category filtering
- **Search Panel**: Gradient search interface with filters
- **Empty State**: Informative empty state messages

## Screens

### 1. Home Screen (`home.dart`)
- Book search with filters
- View of results
- Quick favorite toggle
- Navigation to details

### 2. Detail Screen (`detail.dart`)
- Full book information
- Large cover display
- Rating and publication info
- Add to favorites
- Category badges

### 3. Favorites Screen (`favorites.dart`)
- View all favorite books
- Filter by custom categories
- Manage categories
- Add/remove from categories
- Delete custom categories

## Configuration

### Service Locator Setup
```dart
void setupLocator() {
  // Register repositories
  sl.registerSingleton<RepositoryBook>(RepositoryBookRemote());
  sl.registerSingleton<RepositoryCategory>(RepositoryCategoryLocal());
  
  // Register use cases
  sl.registerSingleton<BookUsecase>(BookUsecase(...));
  sl.registerSingleton<CategoryUsecase>(CategoryUsecase(...));
}
```

---

