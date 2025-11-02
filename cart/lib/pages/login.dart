import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/auth_state.dart';
import '../forms/form_login.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Login page")),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
            
            if (state is AuthStateAuthenticated) {
              Navigator.of(context).pushReplacementNamed("home");
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _isLogin ? null : () {
                          setState(() {
                            _isLogin = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isLogin ? Colors.blue : Colors.grey,
                        ),
                        child: const Text('Login'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _isLogin ? () {
                          setState(() {
                            _isLogin = false;
                          });
                        } : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isLogin ? Colors.grey : Colors.blue,
                        ),
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (!_isLogin)
                          TextFormField(
                            controller: emailCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                          ),
                        
                        if (!_isLogin) const SizedBox(height: 16),
                        
                        TextFormField(
                          controller: usernameCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        TextFormField(
                          controller: passwordCtrl,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            if (!_isLogin && value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 24),
                        
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthStateLoading) {
                              return const CircularProgressIndicator();
                            }
                            
                            return SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (_isLogin) {
                                      context.read<AuthBloc>().add(
                                        AuthLoginEvent(
                                          username: usernameCtrl.text,
                                          password: passwordCtrl.text,
                                        ),
                                      );
                                    } else {
                                      context.read<AuthBloc>().add(
                                        AuthRegisterEvent(
                                          username: usernameCtrl.text,
                                          email: emailCtrl.text,
                                          password: passwordCtrl.text,
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text(_isLogin ? 'Login' : 'Register'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }
}