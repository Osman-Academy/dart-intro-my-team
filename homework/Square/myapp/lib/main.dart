import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'calc.dart';
import 'radius_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Square Shrink',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Shrinkable Square'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: BlocProvider(
        create: (context) => RadiusCubit(),
        child: const Calc(),
      ),
    );
  }
}
