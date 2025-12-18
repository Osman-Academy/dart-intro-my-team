import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(24),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Wizarding World!',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 24),
            BlocConsumer<AuthBloc , AuthState>(
              listener: (context , state){
                if(state is AuthAuthenticated){
                  Navigator.pushReplacementNamed(context, '/characters');

                }

              },
              builder: (context, state){
                return ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      LoginRequested(
                        _usernameController.text,
                        _passwordController.text,
                      ),
                    );
                  },
                  child: const Text('Login'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}