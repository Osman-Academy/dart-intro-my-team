import 'package:flutter/material.dart';
import 'package:navigation/forms/form_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("Login page")),
      body: FormLogin(
        formKey: _formKey,
        lognController: usernameCtrl,
        passwordController: passwordCtrl,
        onSubmit: () {
          if (_formKey.currentState!.validate()) {}
        },
      ),
    ));
  }
}
