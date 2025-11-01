// task3.dart

class User {
  final String username;
  final String password;
  User(this.username, this.password);
}

class AuthRepository {
  final List<User> _users = [];
  User? _currentUser;

  void register(String username, String password) {
    if (_users.any((u) => u.username == username)) {
      print('User already exists.');
      return;
    }
    _users.add(User(username, password));
    print('User "$username" registered successfully.');
  }

  void login(String username, String password) {
    final user = _users.firstWhere(
          (u) => u.username == username && u.password == password,
      orElse: () => User('', ''),
    );
    if (user.username.isEmpty) {
      print('Invalid username or password.');
      return;
    }
    _currentUser = user;
    print('User "$username" logged in successfully.');
  }

  void logout() {
    if (_currentUser == null) {
      print('No user is logged in.');
      return;
    }
    print('User "${_currentUser!.username}" logged out.');
    _currentUser = null;
  }

  bool get isLoggedIn => _currentUser != null;

  User? get currentUser => _currentUser;
}

void main() {
  var authRepo = AuthRepository();

  authRepo.register('john', '1234');
  authRepo.register('john', '1234');
  authRepo.login('john', 'wrong');
  authRepo.login('john', '1234');
  print('Is logged in: ${authRepo.isLoggedIn}');
  authRepo.logout();
  print('Is logged in: ${authRepo.isLoggedIn}');
}
