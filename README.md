📝 Flutter Task Manager

This project is a final assignment for the Dart / Flutter course 🎓 and represents a task manager application developed using Flutter and Dart. The purpose of this project is to demonstrate the application of modern Flutter development practices, including Clean Architecture 🏗, state management with the BLoC pattern 🔄, dependency injection using GetIt 🧩, and immutable data modeling with Freezed and JSON serialization ❄️📦.

The application is connected to a REST API backend 🌐 (JSONPlaceholder) to retrieve task data in JSON format. The app allows users to load tasks from the server 📥, add new tasks ➕, mark tasks as completed ☑️, and search through tasks using pattern-based search with regular expressions 🔍. Since the API is used mainly for demonstration purposes, newly added tasks are managed locally within the application state.

The project is structured into clearly separated layers — data, domain, and presentation — which improves readability, scalability, and maintainability of the codebase 📚. The user interface is built with Flutter’s Material components 🎨 and enhanced with a clean, card-based design. Completed tasks are visually highlighted to provide a better and more intuitive user experience 👀.

This project highlights practical skills in cross-platform application development 💻, including working with RESTful services, asynchronous programming ⏱, scalable state management, dependency injection, and the use of code generation tools to reduce boilerplate and improve code quality ✨.

To run the project locally 🛠, ensure that Flutter is installed, then execute flutter pub get to install dependencies, generate Freezed files with dart run build_runner build --delete-conflicting-outputs, and start the application using flutter run -d chrome.

👩‍🎓 Author

Aikan Abdrashitova
Final project branch: abdrashitova-aikan-final
