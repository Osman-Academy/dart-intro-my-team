import 'dart:convert';
import 'package:dynamic_square/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const String _usersKey = 'users';
  static const String _currentUserKey = 'current_user';

  // Get all registered users
  Future<List<User>> _getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);
    
    if (usersJson == null) return [];
    
    final List<dynamic> usersList = json.decode(usersJson);
    return usersList.map((json) => User.fromJson(json)).toList();
  }

  // Save users list
  Future<void> _saveUsers(List<User> users) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = json.encode(users.map((u) => u.toJson()).toList());
    await prefs.setString(_usersKey, usersJson);
  }

  // Register new user
  Future<AuthResult> register(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      return AuthResult(success: false, message: 'Username and password cannot be empty');
    }

    final users = await _getUsers();
    
    // Check if user already exists
    if (users.any((u) => u.username == username)) {
      return AuthResult(success: false, message: 'Username already exists');
    }

    // Add new user
    users.add(User(username: username, password: password));
    await _saveUsers(users);

    return AuthResult(success: true, message: 'Registration successful');
  }

  // Login
  Future<AuthResult> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      return AuthResult(success: false, message: 'Username and password cannot be empty');
    }

    final users = await _getUsers();
    
    // Find user with matching credentials
    final user = users.firstWhere(
      (u) => u.username == username && u.password == password,
      orElse: () => User(username: '', password: ''),
    );

    if (user.username.isEmpty) {
      return AuthResult(success: false, message: 'Invalid username or password');
    }

    // Save current user
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, username);

    return AuthResult(success: true, message: 'Login successful', user: user);
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_currentUserKey);
  }

  // Get current logged in user
  Future<String?> getCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUserKey);
  }

  // Get all users (for debugging - NEVER do this in production)
  Future<List<User>> getAllUsers() async {
    return await _getUsers();
  }
}

class AuthResult {
  final bool success;
  final String message;
  final User? user;

  AuthResult({required this.success, required this.message, this.user});
}