import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _key = 'auth_token';
  final SharedPreferences prefs;

  TokenStorage(this.prefs);

  Future<void> saveToken(String token) async {
    await prefs.setString(_key, token);
  }

  Future<String?> getToken() async {
    return prefs.getString(_key);
  }

  Future<void> clear() async {
    await prefs.remove(_key);
  }
}
