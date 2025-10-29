import 'package:flutter/material.dart';
import 'auth/auth_repository.dart';
import 'auth/login_page.dart';
import 'auth/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authRepo = AuthRepository();
  await authRepo.loadUser();
  runApp(MyApp(authRepo: authRepo));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepo;
  const MyApp({super.key, required this.authRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authRepo.isLoggedIn
          ? HomePage(authRepository: authRepo)
          : LoginPage(authRepository: authRepo),
    );
  }
}
