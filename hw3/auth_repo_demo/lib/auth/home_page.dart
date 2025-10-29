import 'package:flutter/material.dart';
import 'auth_repository.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  final AuthRepository authRepository;
  const HomePage({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome, ${authRepository.currentUser}!"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authRepository.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(authRepository: authRepository),
                  ),
                );
              },
              child: const Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
