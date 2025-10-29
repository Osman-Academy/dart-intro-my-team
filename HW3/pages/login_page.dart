import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';
import '../models/user.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authRepo = AuthRepository();

  bool _isLoading = false;
  String? _errorMessage;

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    User? user = await _authRepo.login(username, password);

    setState(() => _isLoading = false);

    if (user != null) {
      // Navigate to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(username: user.username),
        ),
      );
    } else {
      setState(() {
        _errorMessage = "Invalid username or password";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ]
          ],
        ),
      ),
    );
  }
}
