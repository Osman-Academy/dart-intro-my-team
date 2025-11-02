// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navigation/pages/app.dart';
import 'package:navigation/bloc/product_bloc.dart';
import 'package:navigation/bloc/cart_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(storage: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences storage;
  const MyApp({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: app,
    );
  }
}