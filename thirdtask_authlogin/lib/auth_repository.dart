class AuthRepository {
  // The simplest "database" of users
  final Map<String, String> users = {
    "user@example.com": "password123",
    "admin@example.com": "admin123"
  };

  //Checks if there is such a user with a password
  bool validateUser(String email, String password) {
    return users[email] == password;
  }
}
