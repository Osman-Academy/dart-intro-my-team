import '../models/user.dart';

class AuthRepository {
  // Mocked user for demonstration
  final User _mockUser = User(username: 'admin', password: '1234');

  Future<User?> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    if (username == _mockUser.username && password == _mockUser.password) {
      return _mockUser;
    } else {
      return null;
    }
  }
}
