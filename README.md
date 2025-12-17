
# Task Manager (Flutter)
Flutter task manager app built to demonstrate:
- Clean Architecture (Presentation / Domain / Data layers)
- Dependency Injection (GetIt)
- BLoC state management
- Freezed for immutable models, unions (events/states)
- Backend integration via REST API (MockAPI)
- String Search by Pattern (case-insensitive contains)

> ⚠️ This repository contains source code only.  
> No APK/IPA/build artifacts, no screenshots, no zips, no submodules.

---

## Features
- Load tasks from backend
- Create new task
- Edit task title
- Delete task
- Toggle task status (completed / not completed)
- Search tasks by pattern (string matching)

---

## Tech Stack
- Flutter + Dart
- flutter_bloc
- get_it
- dio
- freezed + freezed_annotation
- json_serializable + json_annotation
- build_runner

---

## Project Structure (Clean Architecture)

### Layer responsibilities
- **Presentation**: UI + BLoC (events, states)
- **Domain**: Entities + UseCases + Repository interfaces (pure logic)
- **Data**: Models + Remote datasource + Repository implementations (network)

---

## Backend (MockAPI)
This app uses **MockAPI** as a backend.  
The API resource is `tasks` with fields:
- `id` *(String)*
- `title` *(String)*
- `completed` *(Boolean)*

### Configure API URL
Open:

`lib/core/utils/constants.dart`

Set:

```dart
class ApiConstants {
  static const baseUrl = 'https://<your-id>.mockapi.io/<your-path>';
  static const tasksPath = '/tasks';
}
````

> Note: MockAPI returns `id` as **String**, so the app uses `String id` in Entity/Model.

---

## Getting Started

### 1) Install dependencies

```bash
flutter pub get
```

### 2) Generate Freezed / JSON files
```bash
dart run build_runner build --delete-conflicting-outputs
```
### 3) Run the app

#### Web
```bash
flutter run -d chrome
```
#### Android / iOS
```bash
flutter run
```

---
