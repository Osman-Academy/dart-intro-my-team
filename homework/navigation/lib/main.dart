import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/product_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navigation/pages/app.dart';
import 'package:navigation/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final hasToken = prefs.getString("token") != null;

  runApp(MyApp(storage: prefs, isAuthenticated: hasToken));
}

class MyApp extends StatelessWidget {
  final SharedPreferences storage;
  final bool isAuthenticated;
  const MyApp({super.key, required this.storage, required this.isAuthenticated});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ProductBloc())],
      child: MaterialApp(
        title: 'Navigation Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: isAuthenticated ? app : Login(storage: storage),
      ),
    );
  }
}
