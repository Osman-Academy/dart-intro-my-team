import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import 'cart.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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