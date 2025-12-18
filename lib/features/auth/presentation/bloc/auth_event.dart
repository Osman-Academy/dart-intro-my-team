abstract class AuthEvent {}
class LoginRequested extends AuthEvent{
  final String username;
  final String password;
  LoginRequested(this.username, this.password);
}
