import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _username;
  String? _role;

  bool get isAuthenticated => _token != null;
  String? get username => _username;
  String? get role => _role;

  AuthProvider() {
    _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');
    _username = prefs.getString('username');
    _role = prefs.getString('user_role');
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    if ((username == 'customer' && password == 'password') || (username == 'admin' && password == 'admin')) {
      _token = 'mock_jwt_token_for_$username';
      _username = username;
      _role = username;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', _token!);
      await prefs.setString('username', _username!);
      await prefs.setString('user_role', _role!);
      
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _token = null;
    _username = null;
    _role = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    notifyListeners();
  }
}
