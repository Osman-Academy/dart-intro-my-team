import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final SharedPreferences _prefs;

  AuthRepository(this._prefs);

  static const String _tokenKey = 'auth_token';
  static const String _usernameKey = 'username';

  Future<bool> login(String username, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      if (username == 'admin' && password == 'admin') {
        final String token = _generateToken(username);
        await _prefs.setString(_tokenKey, token);
        await _prefs.setString(_usernameKey, username);
        return true;
      }
      
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await _prefs.remove(_tokenKey);
      await _prefs.remove(_usernameKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool isLoggedIn() {
    final token = _prefs.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  String? getUsername() {
    return _prefs.getString(_usernameKey);
  }

  String _generateToken(String username) {
    return '${username}_token_${DateTime.now().millisecondsSinceEpoch}';
  }
}