# CyberTools Shop (Flutter)

**CyberTools Shop** is a Flutter application that demonstrates a
**Cybersecurity Tools catalog** with real backend integration.

---

## Technologies & Concepts

- **Flutter**
- **Clean Architecture**
  - Data / Domain / Presentation layers
- **Dependency Injection** – `get_it`
- **State Management** – `BLoC`
- **Freezed** + `json_serializable`
- **Backend integration** (local Dart server)
- **String Search by Pattern** (wildcards + regex)

---

## Project Structure

shopping/
├── backend/ # Dart backend (shelf)
│ ├── bin/server.dart # HTTP server
│ └── data/tools.json # Cybersecurity tools data
│
├── lib/
│ ├── features/products/
│ │ ├── data/
│ │ ├── domain/
│ │ └── presentation/
│ └── injection.dart # DI container
│
└── pubspec.yaml


---

## ⚙️ Prerequisites (Windows)

1. **Flutter SDK**
   - https://flutter.dev/docs/get-started/install
   - Add Flutter to PATH

2. **Git** (required by Flutter)
   - https://git-scm.com/download/win

3. **VS Code Extensions**
   - Flutter
   - Dart

4. Verify installation:

```bash
flutter doctor


🖥️ Run Backend (Dart Server)

This project uses a local backend written in Dart
(no Node.js, no json-server).

1) Open terminal
cd shopping/backend

2) Install backend dependencies
dart pub get

3) Start the server
dart run bin/server.dart


If successful, you will see:

Backend running on http://0.0.0.0:3000

4) Test backend in browser

List of tools:

http://localhost:3000/products


Single tool:

http://localhost:3000/products/1

📱 Run Flutter App

Open another terminal in the shopping/ folder:

flutter pub get
flutter run -d web-server --web-port 8080


Then open in browser:

http://localhost:8080


Using web-server mode avoids browser launch issues on Windows.