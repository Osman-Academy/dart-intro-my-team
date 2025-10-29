class AuthRepository {
  final Map<String, String> _users = {
    "user@example.com": "password123",
  };

  bool login(String email, String password) {
    if (_users[email] == password) {
      print('✅ Login successful for $email');
      return true;
    } else {
      print('❌ Login failed for $email');
      return false;
    }
  }

  void logout(String email) {
    print('👋 $email logged out');
  }
}

void main() {
  var auth = AuthRepository();

  auth.login("user@example.com", "password123"); 
  auth.login("wrong@example.com", "12345");       
  auth.logout("user@example.com");
}
