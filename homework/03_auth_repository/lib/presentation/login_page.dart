import 'package:flutter/material.dart';
import '../data/auth_repository.dart';

class LoginPage extends StatefulWidget {
  final AuthRepository authRepository;

  const LoginPage({super.key, required this.authRepository});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Auth Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool success = await widget.authRepository.login(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );

                setState(() {
                  message = success ? "Login successful" : "Wrong credentials";
                });
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await widget.authRepository.logout();
                setState(() {
                  message = "Logged out";
                });
              },
              child: const Text("Logout"),
            ),
            const SizedBox(height: 20),
            Text(message, style: const TextStyle(fontSize: 18))
          ],
        ),
      ),
    );
  }
}
