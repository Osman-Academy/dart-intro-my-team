abstract class AuthEvent {}

class AuthLoginEvent implements AuthEvent {
  final String username;
  final String password;

  AuthLoginEvent({required this.username, required this.password});
}

class AuthRegisterEvent implements AuthEvent {
  final String username;
  final String email;
  final String password;

  AuthRegisterEvent({
    required this.username,
    required this.email,
    required this.password,
  });
}

class AuthLogoutEvent implements AuthEvent {}

class AuthCheckEvent implements AuthEvent {}
