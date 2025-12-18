# Harry Potter Explorer App 🪄

## 📱 Project Description

Harry Potter Explorer is a Flutter mobile application that allows users to browse and search characters from the Harry Potter universe.  
The app retrieves data from a real backend API and displays a list of characters with images, houses, and detailed information.

This project was developed as a **Final Project** for the Mobile Application Development course and fully follows the required architectural and technical guidelines.

---

## 🎯 App Concept

**Media / Characters Catalog App**

The application provides:
- A list of Harry Potter characters
- String-based search by character name
- Detailed character information screen
- Clean and themed UI inspired by the Harry Potter universe

---

## 🧱 Architecture

The project follows **Clean Architecture** principles and is divided into three main layers:
data → domain → presentation


### Layers:
- **Data layer**
    - API integration (PotterAPI)
    - Data models using Freezed
    - Repository implementations
- **Domain layer**
    - Entities
    - Abstract repositories
- **Presentation layer**
    - BLoC (Business Logic Component)
    - UI screens (pages)

This separation ensures scalability, testability, and maintainability.

---

## 🔁 State Management

The application uses **BLoC (flutter_bloc)** for state management.

### Implemented states:
- Loading
- Loaded
- Error

### Implemented events:
- LoadCharacters
- SearchCharacters

All business logic is handled inside BLoC, keeping the UI clean.

---

## 💉 Dependency Injection

**GetIt** is used for Dependency Injection.

- Network client (`Dio`) is injected
- Dependencies are not created directly inside UI widgets
- Centralized configuration improves flexibility and testability

---

## ❄️ Freezed & JSON Serialization

The project uses **Freezed annotations** for:
- Immutable data models
- JSON serialization
- Safe and clean data handling

Generated files (`.freezed.dart`, `.g.dart`) are included in the repository as required.

---

## 🔍 Search Functionality

The app supports **string search by pattern**:
- Search is case-insensitive
- Implemented via BLoC
- Filters characters by name in real time

---

## 🌐 Backend Integration

The app is connected to a real backend server:

**PotterAPI**
https://potterapi-fedeperin.vercel.app


Data is retrieved via HTTP requests using Dio, parsed into models, mapped to domain entities, and displayed in the UI.

---

## 🎨 UI & Design

- Dark theme inspired by the Harry Potter universe
- Black background with gold accents
- Character images displayed in list and detail screens
- Clean and readable layout

---

## 📂 Project Structure

lib/
├─ core/
│ ├─ di/
│ └─ theme/
├─ features/
│ ├─ auth/
│ └─ characters/
│ ├─ data/
│ ├─ domain/
│ └─ presentation/
└─ main.dart


---

## 📌 Git & Submission Notes

- The project is pushed to a personal branch:  
  **Surname-Name/final**
- Only source code is included
- No `.apk`, `.ipa`, `.app`, `.zip`, or submodules are added
- No screenshots are included in the repository

---

## 🛠 Technologies Used

- Flutter
- Dart
- BLoC (flutter_bloc)
- GetIt (Dependency Injection)
- Freezed
- Dio (HTTP client)
- PotterAPI (Backend)

---

## ✅ Final Notes

This project satisfies **all Final Project Requirements**, including:
- Clean Architecture
- Dependency Injection
- BLoC
- Freezed annotations
- String-based search
- Backend integration

---

**Author:** Elzada Turdubekova  
**Course:** Mobile Application Development  
**Project Type:** Final Project




