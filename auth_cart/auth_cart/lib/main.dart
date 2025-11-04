import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/cart_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navigation/bloc/product_bloc.dart';
import 'package:navigation/bloc/auth_bloc.dart';
import 'package:navigation/bloc/auth_event.dart';
import 'package:navigation/bloc/cart_bloc.dart'; 
import 'package:navigation/pages/app.dart';

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
        BlocProvider(
            create: (context) =>
                AuthBloc(prefs: storage)..add(AuthCheckEvent())),
        BlocProvider(
            create: (context) =>
                CartBloc(prefs: storage)..add(CartLoadEvent())),
      ],
      child: app,
    );
  }
}
