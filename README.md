## Task Manager App — Setup & Run Instructions
This is a Flutter-based Task Management application that uses BLoC for state management and JSON Server as a REST API backend.

1. Prerequisites
Flutter SDK: Ensure you have Flutter installed and configured.

Node.js: Required to run the JSON Server.

2. Backend Setup (JSON Server)
The app communicates with a local server to fetch and store tasks.

Install json-server globally (if you haven't already):

npm install -g json-server
Navigate to the project root directory and start the server:

json-server db.json --port 3000

Note: The server must be running at http://127.0.0.1:3000/tasks for the app to work.

3. Frontend Setup (Flutter)
Fetch the project dependencies:


flutter pub get
Code Generation: If there are changes in the data models or if you are running the project for the first time, run the following command to generate the necessary files (Freezed/JSON Serializable):


dart run build_runner build --delete-conflicting-outputs
Run the application:

flutter run

4. Key Features
View Tasks: Fetches and displays tasks automatically on startup.

Add Tasks: Click the floating action button (+), enter the title and description in the dialog, and save.

Persistent Storage: Data is saved locally in the db.json file via the backend.
