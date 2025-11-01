class User {
  final String username;
  final String passwordHash;

  const User({required this.username, required this.passwordHash});

  @override
  String toString() => 'User($username)';
}
