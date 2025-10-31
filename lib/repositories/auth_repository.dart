class User {
  final String username;
  final String password;

  const User({required this.username, required this.password});
}

class AuthRepository {
  final List<User> _registeredUsers = [
    User(username: 'admin', password: '1234'),
    User(username: 'user', password: 'abcd'),
  ];

  User? _currentUser;

  bool login(String username, String password) {
    final user = _registeredUsers.firstWhere(
      (u) => u.username == username && u.password == password,
      orElse: () => const User(username: '', password: ''),
    );

    if (user.username.isNotEmpty) {
      _currentUser = user;
      return true;
    }
    return false;
  }

  void logout() => _currentUser = null;

  User? get currentUser => _currentUser;
}
