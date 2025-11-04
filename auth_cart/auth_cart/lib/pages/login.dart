import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/forms/form_login.dart';
import 'package:navigation/bloc/auth_bloc.dart';
import 'package:navigation/bloc/auth_event.dart';
import 'package:navigation/bloc/auth_state.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  void _handleRegister(String username, String email, String password) {
    context.read<AuthBloc>().add(AuthRegisterEvent(
          username: username,
          email: email,
          password: password,
        ));
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthLoginEvent(
            username: usernameCtrl.text,
            password: passwordCtrl.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateAuthenticated) {
          usernameCtrl.clear();
          passwordCtrl.clear();
          Navigator.of(context).pushReplacementNamed("home");
        } else if (state is AuthStateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
          passwordCtrl.clear();
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text("Login")),
          body: FormLogin(
            formKey: _formKey,
            lognController: usernameCtrl,
            passwordController: passwordCtrl,
            onSubmit: _handleLogin,
            onRegister: _handleRegister,
          ),
        ),
      ),
    );
  }
}
