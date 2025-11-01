import 'auth_repository.dart';
class AuthService {
  final AuthRepository repository;
  String? currentUserEmail;

  AuthService(this.repository);

  // Login method via repository
  bool login(String email, String password) {
    bool isValid = repository.validateUser(email, password);
    if (isValid) {
      currentUserEmail = email; 
    }
    return isValid;
  }

  // Exit method
  void logout() {
    currentUserEmail = null; 
  }

  // Authorization check
  bool isLoggedIn() {
    return currentUserEmail != null;
  }

  //Get current user's email
  String? currentUser() {
    return currentUserEmail;
  }
}
