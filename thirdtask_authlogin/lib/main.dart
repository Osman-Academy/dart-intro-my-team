import 'dart:io';
import 'auth_service.dart';
import 'auth_repository.dart';

void main() {
  final repository = AuthRepository();
  final authService = AuthService(repository);

  while (true) {
    print("\nOptions: login / logout / status / exit");
    String? option = stdin.readLineSync()?.toLowerCase();

    if (option == "login") {
      if (authService.isLoggedIn()) {
        print("Already logged in as ${authService.currentUser()}");
        continue;
      }

      print("Enter your email:");
      String? email = stdin.readLineSync();

      print("Enter your password:");
      String? password = stdin.readLineSync();

      if (email != null && password != null) {
        bool success = authService.login(email, password);
        if (success) {
          print("Login successful! Welcome, $email");
        } else {
          print("Incorrect email or password");
        }
      }

    } else if (option == "logout") {
      if (authService.isLoggedIn()) {
        authService.logout();
        print("Logged out successfully");
      } else {
        print("No user is currently logged in");
      }

    } else if (option == "status") {
      if (authService.isLoggedIn()) {
        print("Logged in as: ${authService.currentUser()}");
      } else {
        print("Not logged in");
      }

    } else if (option == "exit") {
      break;
    } else {
      print("Unknown option");
    }
  }
}
