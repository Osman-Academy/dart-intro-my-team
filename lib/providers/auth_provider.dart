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
  String? _refreshToken;

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
      final storedRefreshToken = prefs.getString('auth_refresh_token');
      if (storedToken != null && storedToken.isNotEmpty) {
        _token = storedToken;
        _refreshToken = storedRefreshToken;
        final current = await _service.fetchCurrentUser(storedToken);
        _user = current;
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
      final token = (result['token'] as String?) ?? '';
      final refreshToken = (result['refreshToken'] as String?) ?? '';
      final userJson = result['user'] as Map<String, dynamic>;
      final user = User.fromJson(userJson);
      if (token.isEmpty) {
        throw Exception('Сервер не вернул accessToken');
      }
      _token = token;
      _refreshToken = refreshToken.isNotEmpty ? refreshToken : null;
      _user = user;
      _status = AuthStatus.authenticated;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      if (_refreshToken != null) {
        await prefs.setString('auth_refresh_token', _refreshToken!);
      }
      await prefs.setString('auth_user_id', user.id);
      await prefs.setString('auth_email', user.email);
      await prefs.setString('auth_name', user.name);
      await prefs.setString('auth_username', user.username);
      await prefs.setString('auth_first_name', user.firstName);
      await prefs.setString('auth_last_name', user.lastName);
      await prefs.setString('auth_gender', user.gender);
      await prefs.setString('auth_image', user.image);
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
    _refreshToken = null;
    _errorMessage = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('auth_refresh_token');
    await prefs.remove('auth_user_id');
    await prefs.remove('auth_email');
    await prefs.remove('auth_name');
    await prefs.remove('auth_username');
    await prefs.remove('auth_first_name');
    await prefs.remove('auth_last_name');
    await prefs.remove('auth_gender');
    await prefs.remove('auth_image');
  }

  Future<void> refreshUser() async {
    if (_token == null || _token!.isEmpty) return;
    try {
      final current = await _service.fetchCurrentUser(_token!);
      _user = current;
      if (_status != AuthStatus.authenticated) {
        _status = AuthStatus.authenticated;
      }
      notifyListeners();
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
