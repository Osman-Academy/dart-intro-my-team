Task Manager (Nova Tasks UI) 📝✨
A simple task manager app built with Flutter using Clean Architecture, BLoC, DI (GetIt), Dio for networking, and Freezed for immutable models and JSON serialization.

Table of Contents
🔧 Features
🗂 Project structure
⚙️ Requirements
🚀 Setup & Run
🔁 Code generation
🧪 Testing
🔧 Configuration
⚠️ Known fixes & notes
🤝 Contributing
📜 License



🔧 Features
Clean Architecture (data → domain → presentation)
State management with BLoC (flutter_bloc)
Dependency injection with GetIt
HTTP client using Dio
Models generated with Freezed + json_serializable
Responsive, creative UI (Nova Tasks) with animated cards and radial progress


🗂 Project structure (key files)
pubspec.yaml — package/dependency config
main.dart — app entry
injection.dart — service locator (GetIt)
lib/core/* — network, usecases, utils
dio_client.dart
usecase.dart
constant.dart
task_manager — feature module
data/ (datasources, models: task_model.dart)
domain/ (entities, repositories, usecases)
presentation/ (BLoC, pages: task_page.dart)


⚙️ Requirements
Flutter SDK: >= 3.3.0 and < 4.0.0 (see pubspec.yaml)
Dart (as bundled with Flutter)
Optional: Chrome installed for web target
🚀 Quick start — run locally
Open terminal at project root (where pubspec.yaml is).
Get packages:
flutter pub get

(Generate code — Freezed / JSON serialization)
flutter pub run build_runner build --delete-conflicting-outputs

Analyze:
flutter analyze

Run (Chrome):
flutter run -d chrome

Or run on a connected device/emulator:
flutter run

Tip: Enable web (one-time) if needed:
flutter config --enable-web
flutter devices

🔁 Code generation (Freezed / JSON)
Regenerate code after model changes:
flutter pub run build_runner build --delete-conflicting-outputs

🧪 Tests
Run unit and widget tests:
flutter test

🔧 Configuration
API base URL: constant.dart
Edit the ApiConstants.baseUrl to point to your backend.
Endpoints: ApiConstants.tasksPath
⚠️ Known fixes & recent changes (short changelog) ✅
Fixed import mismatch: changed core/utils/constants.dart → constant.dart.
Fixed DioClient.patch to call dio.patch(...) instead of put.
Fixed lint in usecase.dart: renamed generic Type → Result.
Replaced deprecated .withOpacity(...) uses with .withAlpha(...) to avoid precision-deprecation messages.
UI redesign: replaced TaskPage UI with a new creative, responsive layout in task_page.dart (animated cards, radial progress).
Fixed card overflow issues (responsive widths, reduced paddings, smaller button footprints).
Troubleshooting
If you see missing generated files error, run the codegen command above.
If Flutter doesn't list Chrome, run flutter doctor and enable web support.
If you see runtime DI errors, ensure initDI() is called (it is called in main.dart for this project).
🤝 Contributing
Fork the repo, make changes, run:
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
Open a PR with a short description of your changes.
Troubleshooting
If you see missing generated files error, run the codegen command above.
If Flutter doesn't list Chrome, run flutter doctor and enable web support.
If you see runtime DI errors, ensure initDI() is called (it is called in main.dart for this project).
🤝 Contributing
Fork the repo, make changes, run:
Open a PR with a short description of your changes.