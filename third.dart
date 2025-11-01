class AuthRepository {
  String? _userEmail;

  bool login(String email, String password) {
    if (email == "test@mail.com" && password == "1234") {
      _userEmail = email;
      print("✅ Login successful! Welcome $email");
      return true;
    } else {
      print("❌ Wrong email or password.");
      return false;
    }
  }

  void logout() {
    print("👋 Logged out $_userEmail");
    _userEmail = null;
  }
}

void main() {
  var auth = AuthRepository();

  auth.login("test@mail.com", "1234"); 
  auth.logout();

  auth.login("wrong@mail.com", "pass"); 
  }
