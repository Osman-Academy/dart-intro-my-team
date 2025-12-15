// Main Entry Point
import 'package:flutter/material.dart';
import 'core/di/injection_container.dart';
import 'presentation/screens/user_list_screen.dart';

void main() {
  // Initialize dependency injection
  configureDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      home: const UserListScreen(),
    );
  }
}
