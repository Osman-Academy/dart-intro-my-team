import 'package:flutter/material.dart';
import 'package:navigation/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navigation/forms/form_login.dart';

const String LOGIN = "admin";
const String PASSWORD = "admin";

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
          if (_formKey.currentState!.validate()) {
            if (usernameCtrl.text == LOGIN && passwordCtrl.text == PASSWORD) {
              _setToken("token", usernameCtrl.text + passwordCtrl.text);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Home()));
            }
          }
        },
      ),
    ));
  }

  void _setToken(String key, String value) {
    widget.storage.setString(key, value);
  }
}
