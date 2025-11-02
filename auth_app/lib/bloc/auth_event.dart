abstract class AuthEvent {}

class LoginEvent implements AuthEvent {
  final String username;
  final String password;
  LoginEvent({required this.username, required this.password});
}

class RegisterEvent implements AuthEvent {
  final String username;
  final String email;
  final String password;
  RegisterEvent({
    required this.username,
    required this.email,
    required this.password,
  });
}

class LogoutEvent implements AuthEvent {}