User List
на удивление писать на флаттере было приятнее чем на джаве(яве), лол.
A simple Flutter app that displays a list of users with search functionality. Built using **Clean Architecture**, **BLoC**, **Freezed**, and **Dependency Injection**. The app demonstrates backend integration with fallback to mock data.

p.s подключение к серверу и сбор оттуда данных есть, но так как формально сервера нет, то данные берутся из заглушки!

---
Структура проекта:
lib/
├── core/
│   ├── di/                # Dependency Injection  
├── data/
│   └── user_repository.dart   # Repository with API + mock fallback
├── domain/
│   └── user.dart               # User model (Freezed)
├── presentation/
│   ├── bloc/
│   │   └── user_bloc.dart     # BLoC with search + load
│   └── user_list_screen.dart # UI with search bar and list
├── main.dart

Install dependencies:
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d chrome
http://localhost:3000/ 
