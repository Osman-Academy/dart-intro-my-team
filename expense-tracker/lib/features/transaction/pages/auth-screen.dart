import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SupaEmailAuth(
          onSignInComplete: (response) async {
            if (response.session != null) {
                Navigator.pushReplacementNamed(context, '/home');
            }
          },
          onSignUpComplete: (response) {
            if (response.session != null) {
                Navigator.pushReplacementNamed(context, '/home');
            }
          },
          metadataFields: [
            MetaDataField(
              label: 'Имя',
              key: 'full_name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введите имя';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}