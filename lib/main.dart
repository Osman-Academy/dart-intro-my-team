import 'package:flutter/material.dart';
import 'injection/injection.dart';
import 'presentation/pages/tasks_page.dart';
import 'core/theme/app_theme.dart';


void main() {
  // Initialize dependency injection before the app starts.
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pattern Search Tasks',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const TasksPage(),
    );
  }
}
