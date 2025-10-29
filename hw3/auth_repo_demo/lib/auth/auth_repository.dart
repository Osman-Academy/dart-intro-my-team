import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final Map<String, String> _users = {
    'men@gmail.com': '12345',
    'sen@gmail.com': '54321',
  };

  String? _currentUser;

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUser = prefs.getString('loggedInUser');
  }

  Future<bool> login(String email, String password) async {
    if (_users[email] == password) {
      _currentUser = email;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('loggedInUser', email);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUser');
  }

  bool get isLoggedIn {
    return _currentUser != null;
  }

  String? get currentUser {
    return _currentUser;
  }
}
