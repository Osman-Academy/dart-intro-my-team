import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepoDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthRepoDemo();
  }
}

class _AuthRepoDemo extends State<AuthRepoDemo> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));

    _checkLoggedIn();
  }

  void _login() async {
    bool success = await _authRepository.login(
      _usernameController.text,
      _passwordController.text,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You are logged in as ${_usernameController.text}',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  void _checkLoggedIn() async {
    var isLoggedIn = await _authRepository.checkLoggedIn();
    if (isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You are already logged in',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auth Repo Demo')),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                  child: Column(children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      hintText: 'Enter a username',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: 'Enter a password',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  child: Text("Log in", style: TextStyle(color: Colors.white)),
                  onPressed: _login,
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  child: Text("Log out", style: TextStyle(color: Colors.white)),
                  onPressed: _authRepository.logout,
                  color: Colors.blue,
                )
              ]))
            ],
          )),
    );
  }
}

class UserRepository {
  Future<bool> checkLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    var token = await preferences.getString('token');
    if (token == "token") {
      return true;
    }
    return false;
  }

  Future<bool> login(String username, String password) async {
    if (username == "admin" && password == "123") {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString("token", "token");
      return true;
    }
    return false;
  }

  void logout() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("token", "");
  }
}
