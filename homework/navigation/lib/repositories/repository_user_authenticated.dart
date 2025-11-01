import 'package:shared_preferences/shared_preferences.dart';

class UserAuthRepository {
  static const String _login = "admin";
  static const String _password = "admin";

  final SharedPreferences storage;

  UserAuthRepository({required this.storage});

  bool validateCredentials(String username, String password) {
    return username == _login && password == _password;
  }

  Future<void> saveToken(String key, String value) async {
    await storage.setString(key, value);
  }

  String? getToken(String key) {
    return storage.getString(key);
  }

  Future<void> clearToken(String key) async {
    await storage.remove(key);
  }
}
