import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navigation/models/user.dart';
import 'package:navigation/bloc/auth_event.dart';
import 'package:navigation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SharedPreferences prefs;
  static const String _usersKey = 'registered_users';

  AuthBloc({required this.prefs}) : super(AuthStateInitial()) {
    on<AuthLoginEvent>(_onLogin);
    on<AuthRegisterEvent>(_onRegister);
    on<AuthLogoutEvent>(_onLogout);
    on<AuthCheckEvent>(_onCheckAuth);
  }

  List<User> _getRegisteredUsers() {
    final usersJson = prefs.getString(_usersKey);
    if (usersJson == null) return [];

    try {
      final List<dynamic> usersList = jsonDecode(usersJson);
      return usersList.map((userJson) => User.fromJson(userJson)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> _saveUsers(List<User> users) async {
    final usersJson = jsonEncode(users.map((user) => user.toJson()).toList());
    await prefs.setString(_usersKey, usersJson);
  }

  User? _findUserByUsername(String username) {
    final users = _getRegisteredUsers();
    try {
      return users.firstWhere(
        (user) => user.username == username,
      );
    } catch (e) {
      return null;
    }
  }

  bool _userExists(String username) {
    return _findUserByUsername(username) != null;
  }

  void _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (event.username.isEmpty || event.password.isEmpty) {
        emit(AuthStateError(message: "Please fill all fields"));
        return;
      }

      final User? user = _findUserByUsername(event.username);

      if (user == null) {
        emit(AuthStateError(message: "User not found. Please register first."));
        return;
      }

      if (user.password != event.password) {
        emit(AuthStateError(message: "Invalid password"));
        return;
      }

      await prefs.setString(
          'current_user', jsonEncode(user.toJsonWithoutPassword()));
      await prefs.setBool('isLoggedIn', true);

      emit(AuthStateAuthenticated(user: user));
    } catch (e) {
      emit(AuthStateError(message: "Login failed: ${e.toString()}"));
    }
  }

  void _onRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (event.username.isEmpty ||
          event.email.isEmpty ||
          event.password.isEmpty) {
        emit(AuthStateError(message: "Please fill all fields"));
        return;
      }

      if (event.password.length < 6) {
        emit(AuthStateError(message: "Password must be at least 6 characters"));
        return;
      }

      if (_userExists(event.username)) {
        emit(AuthStateError(message: "Username already exists"));
        return;
      }

      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: event.username,
        email: event.email,
        password: event.password,
      );

      final users = _getRegisteredUsers();
      users.add(user);
      await _saveUsers(users);

      await prefs.setString(
          'current_user', jsonEncode(user.toJsonWithoutPassword()));
      await prefs.setBool('isLoggedIn', true);

      emit(AuthStateAuthenticated(user: user));
    } catch (e) {
      emit(AuthStateError(message: "Registration failed: ${e.toString()}"));
    }
  }

  void _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    await prefs.remove('current_user');
    await prefs.remove('isLoggedIn');

    emit(AuthStateUnauthenticated());
  }

  void _onCheckAuth(AuthCheckEvent event, Emitter<AuthState> emit) async {
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final userJson = prefs.getString('current_user');

    if (isLoggedIn && userJson != null) {
      try {
        final userData = jsonDecode(userJson);
        final user = User(
          id: userData['id']?.toString() ?? '',
          username: userData['username'] ?? '',
          email: userData['email'] ?? '',
          password: '', 
        );
        emit(AuthStateAuthenticated(user: user));
      } catch (e) {
        emit(AuthStateUnauthenticated());
      }
    } else {
      emit(AuthStateUnauthenticated());
    }
  }
}
