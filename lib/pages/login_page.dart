import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthService>();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _emailC, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _passC, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 12),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading
                  ? null
                  : () async {
                setState(() { _loading = true; _error = null; });
                final ok = await auth.login(_emailC.text, _passC.text);
                setState(() { _loading = false; });
                if (ok) {
                  if (mounted) Navigator.of(context).pop();
                } else {
                  setState(() { _error = 'Login failed: wrong credentials'; });
                }
              },
              child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
