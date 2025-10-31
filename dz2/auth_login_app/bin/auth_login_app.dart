import 'dart:io';
import 'package:auth_login_app/repositories/auth_repository.dart';

void main() async {
  final authRepo = AuthRepository();

  print('=== Welcome to AuthLogin Demo ===');
  while (true) {
    print('\nChoose an option:');
    print('1. Register');
    print('2. Login');
    print('3. Logout');
    print('4. Exit');

    stdout.write('Enter choice: ');
    final choice = stdin.readLineSync();

    if (choice == '1') {
      stdout.write('Enter email: ');
      final email = stdin.readLineSync() ?? '';
      stdout.write('Enter password: ');
      final password = stdin.readLineSync() ?? '';
      await authRepo.register(email, password);
    } else if (choice == '2') {
      stdout.write('Enter email: ');
      final email = stdin.readLineSync() ?? '';
      stdout.write('Enter password: ');
      final password = stdin.readLineSync() ?? '';
      await authRepo.login(email, password);
    } else if (choice == '3') {
      await authRepo.logout();
    } else if (choice == '4') {
      print('👋 Goodbye!');
      break;
    } else {
      print('⚠️ Invalid choice');
    }
  }
}
