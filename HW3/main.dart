import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() => runApp(const ShrinkSquareApp());

class ShrinkSquareApp extends StatelessWidget {
  const ShrinkSquareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
