import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

enum AuthStatus { unknown, unauthenticated, authenticating, authenticated, error }

class AuthProvider with ChangeNotifier {
  final AuthService _service;

  AuthStatus _status = AuthStatus.unknown;
  User? _user;
  String? _token;
  String? _errorMessage;

  AuthProvider({AuthService? service}) : _service = service ?? AuthService();

  AuthStatus get status => _status;
  User? get user => _user;
  String? get token => _token;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated && _user != null;

  Future<void> initAuth() async {
    _status = AuthStatus.authenticating;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedToken = prefs.getString('auth_token');
      final storedUserId = prefs.getString('auth_user_id');
      final storedEmail = prefs.getString('auth_email');
      final storedName = prefs.getString('auth_name');

      if (storedToken != null && storedUserId != null && storedName != null) {
        _token = storedToken;
        _user = User(
          id: storedUserId,
          email: storedEmail ?? '',
          name: storedName,
        );
        _status = AuthStatus.authenticated;
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> login({required String username, required String password}) async {
    _status = AuthStatus.authenticating;
    _errorMessage = null;
    notifyListeners();
    try {
      final result = await _service.login(username, password);
      final token = result['token'] as String;
      final userJson = result['user'] as Map<String, dynamic>;
      final user = User.fromJson(userJson);

      _token = token;
      _user = user;
      _status = AuthStatus.authenticated;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      await prefs.setString('auth_user_id', user.id);
      await prefs.setString('auth_email', user.email);
      await prefs.setString('auth_name', user.name);
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _status = AuthStatus.unauthenticated;
    _user = null;
    _token = null;
    _errorMessage = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('auth_user_id');
    await prefs.remove('auth_email');
    await prefs.remove('auth_name');
  }
}
