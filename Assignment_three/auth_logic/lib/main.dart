import 'package:flutter/material.dart';
import 'auth_logic.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController _field1Controller = TextEditingController();
  final TextEditingController _field2Controller = TextEditingController();
  UserData _userData = UserData();
  bool _isLoggedIn = false;
  String? _errorMessage;
  @override
  void dispose() {
    _field1Controller.dispose();
    _field2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Authorization App')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              if (_isLoggedIn) ...[
                Text(
                  "You're logged as: ${_userData.email}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoggedIn = false;
                        _errorMessage = null;
                        _field1Controller.clear();
                        _field2Controller.clear();
                        _userData.logout();
                      });
                    },
                    child: const Text('Logout'),
                  ),
                ),

              ] else ...[
                TextField(
                  controller: _field1Controller,
                  decoration: const InputDecoration(
                    labelText: 'Login',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: _field2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final login = _field1Controller.text;
                      final password = _field2Controller.text;
                      _userData = UserData(email: login);
                      final success = _userData.login(password);
                      setState(() {
                        if (success) {
                          _isLoggedIn = true;
                          _errorMessage = null;
                        } else {
                          _isLoggedIn = false;
                          _errorMessage = 'Login failed. Please check your credentials.';
                        }
                      });
                    },
                    child: const Text('Submit'),
                  ),
                ),

                if (_errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
