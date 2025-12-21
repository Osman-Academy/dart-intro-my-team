import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di.dart';
import 'presentation/bloc/user_bloc.dart';
import 'presentation/user_list_screen.dart';

void main() {
  setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List App',
      theme: ThemeData(useMaterial3: true),
      home: BlocProvider(
        create: (_) => getIt<UserBloc>(),
        child: const UserListScreen(),
      ),
    );
  }
}
