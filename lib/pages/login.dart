import 'package:flutter/material.dart';
import 'package:navigation/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navigation/forms/form_login.dart';
import 'package:navigation/repositories/auth_repository.dart';

class Login extends StatefulWidget {
  final SharedPreferences storage;
  const Login({super.key, required this.storage});
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  late AuthRepository _authRepository;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository(widget.storage);
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final success = await _authRepository.login(
          usernameCtrl.text.trim(),
          passwordCtrl.text.trim(),
        );

        if (success) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Home()),
          );
        } else {
          _showErrorDialog('Invalid username or password. Use: admin / admin');
        }
      } catch (e) {
        _showErrorDialog('Login failed. Please try again.');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: _isLoading 
            ? const Center(child: CircularProgressIndicator())
            : FormLogin(
                formKey: _formKey,
                lognController: usernameCtrl,
                passwordController: passwordCtrl,
                onSubmit: _handleLogin,
              ),
      ),
    );
  }
}