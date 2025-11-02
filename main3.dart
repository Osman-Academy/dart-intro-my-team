import 'dart:async';
import 'dart:io';

void main() async {
  final authRepo = AuthRepository();

  stdout.write('Enter email: ');
  String email = stdin.readLineSync() ?? '';

  stdout.write('Enter password: ');
  String password = stdin.readLineSync() ?? '';

  bool success = await authRepo.login(email, password);

  if (success) {
    print('Auth succeed!');
  } else {
    print('Invalid email or password');
  }
}

class AuthRepository {
  final Map<String, String> _users = {
    'user@gmail.com': 'password123',
  };

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    return _users[email] == password;
  }
}
