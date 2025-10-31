class AuthRepository {
  // Dummy users
  final Map<String, String> _users = {
    'user@example.com': '123456',
    'admin@quizme.com': 'adminpass',
  };

  /// Simulate login
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    if (_users.containsKey(email) && _users[email] == password) {
      print('✅ Login successful for $email');
      return true;
    } else {
      print('❌ Invalid credentials for $email');
      return false;
    }
  }

  /// Simulate registration
  Future<void> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_users.containsKey(email)) {
      print('⚠️ User already exists');
    } else {
      _users[email] = password;
      print('✅ Registered successfully');
    }
  }

  /// Simulate logout
  Future<void> logout() async {
    print('👋 Logged out');
  }
}
