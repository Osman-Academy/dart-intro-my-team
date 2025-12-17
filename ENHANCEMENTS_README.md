# Clean Architecture Task Manager - Enhanced Edition

A complete Flutter Task Manager app built with **Clean Architecture**, **BLoC**, **Freezed**, and **GetIt Dependency Injection**. This enhanced version includes full CRUD operations, advanced UI features, and comprehensive state management.

## 🏗️ Architecture Overview

The project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                    # Core utilities, constants, errors
│   ├── constants.dart       # API base URL
│   └── errors/
│       └── exceptions.dart  # Custom exceptions (ServerException)
│
├── data/                    # Data layer - external data sources
│   ├── datasources/
│   │   └── task_remote_datasource.dart  # HTTP client for remote API
│   ├── models/
│   │   └── task_model.dart  # Freezed data model with JSON serialization
│   └── repositories/
│       └── task_repository_impl.dart    # Repository implementation
│
├── domain/                  # Domain layer - business logic
│   ├── entities/
│   │   └── task.dart        # Task entity (core business object)
│   ├── repositories/
│   │   └── task_repository.dart         # Repository interface
│   └── usecases/            # Use cases for business operations
│       ├── get_tasks.dart
│       ├── add_task.dart
│       ├── update_task.dart
│       └── delete_task.dart
│
├── presentation/            # Presentation layer - UI
│   ├── bloc/
│   │   ├── task_bloc.dart
│   │   ├── task_event.dart  # Events for all task operations
│   │   └── task_state.dart  # States for all task states
│   ├── pages/
│   │   └── tasks_page.dart  # Main tasks list page
│   └── widgets/
│       ├── task_item.dart           # Single task list item
│       ├── add_task_dialog.dart     # Dialog for adding tasks
│       └── task_search_bar.dart     # Search/filter widget
│
├── injection_container.dart # GetIt dependency injection setup
└── main.dart               # App entry point with BLoC provider
```

## ✨ Features

### UI Enhancements
- **ListView of Tasks** - Display tasks with title, description, and status
- **Checkboxes** - Toggle task completion status directly from the list
- **Delete Button** - Remove tasks with confirmation dialog
- **FloatingActionButton** - Add new tasks with a bottom sheet + dialog
- **Pull-to-Refresh** - Swipe to refresh the task list
- **Search/Filter** - Filter tasks by title or description (toggleable search bar)
- **Loading States** - Shows circular progress indicator while fetching
- **Error Handling** - Displays error messages with retry button
- **Empty State** - Shows friendly message when no tasks are present
- **Operation Overlay** - Semi-transparent overlay during add/delete/update

### BLoC & State Management
The **TaskBloc** manages all task-related operations with comprehensive event/state combinations:

#### Events:
- `FetchTasks` - Initial load of all tasks
- `RefreshTasks` - Pull-to-refresh operation
- `AddTaskEvent` - Create a new task
- `ToggleTaskCompletion` - Mark task as done/undone
- `DeleteTaskEvent` - Remove a task
- `SearchTasks` - Filter tasks by query
- `ClearSearch` - Show all tasks again

#### States:
- `TaskInitial` - Initial state
- `TaskLoading` - Fetching tasks
- `TaskRefreshing` - Refreshing with previous tasks visible
- `TaskLoaded` - Tasks successfully loaded
- `TaskEmpty` - No tasks found or list is empty
- `TaskError` - Error occurred
- `TaskOperationLoading` - Add/delete/update in progress
- `TaskAdded` - Task successfully created
- `TaskUpdated` - Task successfully updated
- `TaskDeleted` - Task successfully removed

### Data Layer

#### TaskRemoteDataSource
- **fetchTasks()** - GET /todos
- **createTask()** - POST /todos
- **updateTask()** - PUT /todos/:id
- **deleteTask()** - DELETE /todos/:id

All methods include proper error handling with `ServerException`.

#### TaskRepositoryImpl
Converts `TaskModel` to `Task` domain entities and vice versa. Provides the interface for all CRUD operations.

### Dependency Injection (GetIt)
All dependencies are registered in `injection_container.dart`:
- `http.Client` - HTTP client for making requests
- `TaskRemoteDataSource` - Remote data source
- `TaskRepository` - Repository implementation
- `GetTasks` - Use case for fetching tasks
- `AddTask` - Use case for creating tasks
- `UpdateTask` - Use case for updating tasks
- `DeleteTask` - Use case for deleting tasks

## 🚀 Getting Started

### Prerequisites
- Flutter 3.7+
- Dart 3.0+

### Installation

1. **Install dependencies:**
```bash
flutter pub get
```

2. **Generate code (Freezed + JSON serialization):**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. **Run the app:**
```bash
flutter run
```

## 📦 Dependencies

### Core
- `flutter_bloc: ^8.1.3` - State management
- `bloc: ^8.1.0` - BLoC pattern
- `get_it: ^7.6.0` - Service locator/DI
- `equatable: ^2.0.5` - Value equality

### Data
- `http: ^0.13.6` - HTTP client
- `freezed_annotation: ^2.2.0` - Freezed models
- `json_annotation: ^4.8.0` - JSON serialization

### Dev
- `build_runner: ^2.4.6` - Code generation
- `freezed: ^2.3.2` - Freezed code generation
- `json_serializable: ^6.6.1` - JSON serialization

## 📋 Example Task JSON (from API)

```json
{
  "userId": 1,
  "id": 1,
  "title": "delectus aut autem",
  "completed": false
}
```

**Note:** The JSONPlaceholder API doesn't include a `description` field. When fetched, it defaults to an empty string. When creating tasks, you can add descriptions locally.

## 🎯 Usage Examples

### Fetching Tasks
```dart
// Automatically triggered on app startup
// Or manually:
context.read<TaskBloc>().add(const FetchTasks());
```

### Adding a Task
```dart
context.read<TaskBloc>().add(
  AddTaskEvent(
    title: 'My Task',
    description: 'Task description',
  ),
);
```

### Toggling Task Completion
```dart
context.read<TaskBloc>().add(
  ToggleTaskCompletion(
    taskId: 1,
    completed: true,
  ),
);
```

### Deleting a Task
```dart
context.read<TaskBloc>().add(const DeleteTaskEvent(taskId));
```

### Searching Tasks
```dart
context.read<TaskBloc>().add(const SearchTasks('query'));
```

## 🧪 Testing the App

1. **Run the app** - Tasks are fetched from the JSONPlaceholder API
2. **Pull to refresh** - Swipe down to reload tasks
3. **Add a task** - Tap the + button to create a new task
4. **Toggle completion** - Tap the checkbox to mark as done
5. **Delete a task** - Tap the trash icon and confirm
6. **Search tasks** - Tap the search icon in the app bar to filter

## 📝 Best Practices Implemented

✅ Clean Architecture with clear layer separation
✅ Freezed models for immutability and equality
✅ Repository pattern for data abstraction
✅ Use cases for business logic
✅ BLoC for state management
✅ GetIt for dependency injection
✅ Comprehensive error handling
✅ Pull-to-refresh for data refresh
✅ Loading and error states
✅ Empty state handling
✅ Search and filter functionality
✅ Operation feedback (snackbars, dialogs)
✅ Immutable widgets and proper state management

## 🔄 Data Flow

```
UI (TasksPage)
  ↓
BLoC (TaskBloc) receives events
  ↓
Use Cases (GetTasks, AddTask, UpdateTask, DeleteTask)
  ↓
Repository Interface
  ↓
Repository Implementation
  ↓
Remote Data Source (HTTP calls)
  ↓
External API (JSONPlaceholder)
```

## 🐛 Troubleshooting

### Code generation not working
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Build errors after code changes
Run the above commands and rebuild:
```bash
flutter clean
flutter pub get
flutter run
```

## 📄 License

This project is provided as-is for educational purposes.

---

**Happy coding!** 🎉
