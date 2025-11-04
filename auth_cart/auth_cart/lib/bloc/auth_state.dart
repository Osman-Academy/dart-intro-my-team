import 'package:navigation/models/user.dart';

abstract class AuthState {}

class AuthStateInitial implements AuthState {}

class AuthStateLoading implements AuthState {}

class AuthStateAuthenticated implements AuthState {
  final User user;

  AuthStateAuthenticated({required this.user});
}

class AuthStateUnauthenticated implements AuthState {}

class AuthStateError implements AuthState {
  final String message;

  AuthStateError({required this.message});
}
