import 'package:flutter/material.dart';
import 'package:navigation/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navigation/forms/form_login.dart';
import 'package:navigation/repositories/repository_user_authenticated.dart';

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

  late final UserAuthRepository authRepo;

  @override
  void initState() {
    super.initState();
    authRepo = UserAuthRepository(storage: widget.storage);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text("Login page")),
          body: FormLogin(
            formKey: _formKey,
            lognController: usernameCtrl,
            passwordController: passwordCtrl,
            onSubmit: () {
              if (_formKey.currentState!.validate()) {
                final username = usernameCtrl.text;
                final password = passwordCtrl.text;

                if (authRepo.validateCredentials(username, password)) {
                  authRepo.saveToken("token", username + password);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                }
              }
            },
          ),
        ));
  }
}
