import 'package:auth_app/models/user.dart';

abstract class AuthState {}

class AuthInitial implements AuthState {}

class AuthLoading implements AuthState {}

class AuthSuccess implements AuthState {
  final User user;
  AuthSuccess({required this.user});
}

class AuthError implements AuthState {
  final String message;
  AuthError({required this.message});
}