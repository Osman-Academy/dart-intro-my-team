# Final Project: User List Application

**Clean Architecture | BLoC Pattern | Dependency Injection | Freezed | Backend Integration**

---

## 📋 Project Overview

This is a Flutter application that demonstrates professional software architecture patterns and modern development practices. The app fetches and displays a list of users from a remote API with real-time search functionality.

### Key Features

- ✅ **Clean Architecture** - Separation of concerns with Domain, Data, and Presentation layers
- ✅ **BLoC State Management** - Predictable state management using flutter_bloc
- ✅ **Dependency Injection** - Automatic DI with get_it and injectable
- ✅ **Freezed Annotations** - Immutable models and sealed unions
- ✅ **Backend Integration** - Live data from JSONPlaceholder API
- ✅ **Pattern Search** - Real-time string pattern matching across multiple fields
- ✅ **Error Handling** - Comprehensive error handling with Either type (dartz)
- ✅ **Pull to Refresh** - Manual data refresh capability
- ✅ **Material Design** - Modern UI with Material 3

---

## 🏗️ Architecture

The project follows **Clean Architecture** principles with three distinct layers:

```
┌─────────────────────────────────────────────────────────┐
│                   PRESENTATION LAYER                    │
│  ┌──────────────┐  ┌─────────────┐  ┌──────────────┐  │
│  │    BLoC      │  │   Screens   │  │   Widgets    │  │
│  │ (Events,     │  │             │  │              │  │
│  │  States)     │  │             │  │              │  │
│  └──────────────┘  └─────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│                     DOMAIN LAYER                        │
│  ┌──────────────┐  ┌─────────────┐  ┌──────────────┐  │
│  │   Entities   │  │ Repository  │  │  Use Cases   │  │
│  │   (Freezed)  │  │ Interfaces  │  │              │  │
│  └──────────────┘  └─────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│                      DATA LAYER                         │
│  ┌──────────────┐  ┌─────────────┐  ┌──────────────┐  │
│  │    Models    │  │ Data Source │  │  Repository  │  │
│  │   (DTOs)     │  │  (Remote)   │  │     Impl     │  │
│  └──────────────┘  └─────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
```

---

## 📂 Project Structure

```
final_user_list_app/
├── lib/
│   ├── core/                          # Core functionality
│   │   ├── di/                        # Dependency Injection
│   │   │   ├── injection_container.dart
│   │   │   └── register_module.dart
│   │   └── error/                     # Error handling
│   │       ├── exceptions.dart
│   │       └── failures.dart
│   │
│   ├── domain/                        # Business Logic Layer
│   │   ├── entities/                  # Domain entities (Freezed)
│   │   │   └── user.dart
│   │   ├── repositories/              # Repository contracts
│   │   │   └── user_repository.dart
│   │   └── usecases/                  # Business use cases
│   │       └── get_users.dart
│   │
│   ├── data/                          # Data Layer
│   │   ├── models/                    # Data Transfer Objects
│   │   │   └── user_model.dart
│   │   ├── datasources/               # API communication
│   │   │   └── user_remote_data_source.dart
│   │   └── repositories/              # Repository implementations
│   │       └── user_repository_impl.dart
│   │
│   ├── presentation/                  # UI Layer
│   │   ├── bloc/                      # State Management
│   │   │   ├── user_bloc.dart
│   │   │   ├── user_event.dart
│   │   │   └── user_state.dart
│   │   ├── screens/                   # Screen widgets
│   │   │   └── user_list_screen.dart
│   │   └── widgets/                   # Reusable components
│   │       ├── search_bar_widget.dart
│   │       ├── user_card.dart
│   │       └── user_detail_dialog.dart
│   │
│   └── main.dart                      # Application entry point
│
├── pubspec.yaml                       # Dependencies
├── build.yaml                         # Build configuration
├── analysis_options.yaml              # Linter rules
├── .gitignore                         # Git ignore rules
├── setup.bat                          # Windows setup script
├── README.md                          # Project documentation
└── SETUP_INSTRUCTIONS.md              # Detailed setup guide
```

---

## 🚀 Quick Start

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Internet connection (for API calls)

### Installation

1. **Navigate to project directory:**
   ```bash
   cd final_user_list_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate code (Freezed, Injectable, JSON):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

### Quick Setup (Windows)
```bash
cd final_user_list_app
setup.bat
```

---

## 🛠️ Technologies & Packages

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_bloc` | ^8.1.3 | State management |
| `freezed` | ^2.4.5 | Code generation for models |
| `injectable` | ^2.3.2 | Dependency injection |
| `get_it` | ^7.6.4 | Service locator |
| `dio` | ^5.4.0 | HTTP client |
| `dartz` | ^0.10.1 | Functional programming (Either) |
| `flutter_spinkit` | ^5.2.0 | Loading indicators |

---

## 📱 Features in Detail

### 1. User List Display
- Fetches users from JSONPlaceholder API
- Displays user information in card format
- Shows avatar, name, username, email, phone, and address

### 2. Real-Time Search
Search across multiple fields:
- Name
- Email
- Username
- Phone number

The search is:
- ✅ Case-insensitive
- ✅ Real-time (updates as you type)
- ✅ Pattern-based matching

### 3. User Details
- Tap any user card to view full details
- Modal dialog with complete information:
  - Contact information
  - Full address details
  - Company information

### 4. Pull to Refresh
- Swipe down to refresh the user list
- Maintains search state during refresh

### 5. Error Handling
- Network error detection
- Server error handling
- User-friendly error messages
- Retry functionality

---

## 🔄 State Management Flow

```
User Action (Search/Load)
        │
        ▼
    BLoC Event
        │
        ▼
    Use Case
        │
        ▼
   Repository
        │
        ▼
  Data Source (API)
        │
        ▼
    BLoC State
        │
        ▼
   UI Updates
```

---

## 🎯 Clean Architecture Principles

### Domain Layer (Business Logic)
- Contains business entities and rules
- No dependencies on outer layers
- Pure Dart code (no Flutter imports)

### Data Layer (Data Management)
- Implements repository interfaces
- Handles API communication
- Converts DTOs to domain entities

### Presentation Layer (UI)
- Contains UI components
- Manages UI state with BLoC
- Depends on domain layer only

---

## 🔐 Dependency Injection

The app uses **injectable** with **get_it** for automatic dependency injection:

```dart
@injectable                    // Automatically registered
class UserBloc extends Bloc {
  final GetUsers getUsers;
  UserBloc(this.getUsers);     // Dependencies injected
}
```

Configuration is generated automatically during build.

---

## 📝 Freezed Usage

All models use Freezed for:
- Immutability
- Code generation
- Union types (for states/events)
- JSON serialization
- CopyWith methods

Example:
```dart
@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String email,
    // ...
  }) = _User;
  
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

---

## 🌐 API Integration

**Base URL:** `https://jsonplaceholder.typicode.com`

**Endpoints:**
- `GET /users` - Fetch all users
- `GET /users/:id` - Fetch user by ID

The API is public and requires no authentication.

---

## 📦 Git Push Instructions

### Important: What NOT to Push
- ❌ .apk, .ipa, or .app files
- ❌ Submodules
- ❌ .zip archives
- ❌ Screenshots
- ❌ Generated files (*.g.dart, *.freezed.dart, *.config.dart)

### Push to Your Branch

1. **Create your branch:**
   ```bash
   git checkout -b Surname-Name/final
   ```

2. **Stage your changes:**
   ```bash
   git add .
   ```

3. **Commit:**
   ```bash
   git commit -m "Final project: User list app with clean architecture"
   ```

4. **Push:**
   ```bash
   git push origin Surname-Name/final
   ```

---

## ✅ Requirements Checklist

- [x] **Clean Architecture** - Domain, Data, Presentation layers
- [x] **Dependency Injection** - Injectable + GetIt
- [x] **BLoC Pattern** - State management with events/states
- [x] **Freezed Annotations** - All models and states
- [x] **String Search** - Pattern-based search functionality
- [x] **Backend Integration** - JSONPlaceholder API
- [x] **Source Code Only** - No binaries or generated files

---

## 🧪 Testing the App

After setup, verify:
1. ✅ App launches successfully
2. ✅ Users load from API
3. ✅ Search filters users in real-time
4. ✅ User details dialog opens on tap
5. ✅ Pull-to-refresh works
6. ✅ Error states display correctly

---

## 📄 Additional Documentation

For detailed setup instructions, see [SETUP_INSTRUCTIONS.md](final_user_list_app/SETUP_INSTRUCTIONS.md)

---

## 👨‍💻 Development Notes

### Code Generation
Generated files are excluded from version control (.gitignore). Anyone cloning this repository must run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Adding New Features
Follow the clean architecture pattern:
1. Create entity in domain layer
2. Create use case
3. Implement data source and repository
4. Create BLoC with events/states
5. Build UI components

---

## 📧 Contact

For questions or issues, please contact the development team.

---

**Built with Flutter 💙**
