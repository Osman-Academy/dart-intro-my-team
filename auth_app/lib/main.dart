import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_app/pages/app.dart';
import 'package:auth_app/bloc/product_bloc.dart';
import 'package:auth_app/bloc/auth_bloc.dart';
import 'package:auth_app/repositories/repository_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
      ],
      child: const App(),
    );
  }
}