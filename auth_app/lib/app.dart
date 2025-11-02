import 'package:flutter/material.dart';
import 'package:auth_app/pages/login.dart';
import 'package:auth_app/pages/home.dart';
import 'package:auth_app/pages/cart.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Login(),
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => Login(),
        '/cart': (context) => CartPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}