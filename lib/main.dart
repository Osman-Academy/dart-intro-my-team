import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/product/product_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navigation/pages/app.dart';
import 'package:navigation/bloc/cart/cart_bloc.dart';
import 'package:navigation/pages/login.dart';
import 'package:navigation/repositories/auth_repository.dart';
import 'package:navigation/pages/home.dart';
import 'package:navigation/pages/detail.dart';

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
    final AuthRepository authRepository = AuthRepository(storage);
    
    final bool isLoggedIn = authRepository.isLoggedIn();
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp(
        title: 'Shopping App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: isLoggedIn ? Home() : Login(storage: storage),
        routes: {
          "home": (context) => Home(),
          "product": (context) => Detail(),
          "login": (context) => Login(storage: storage),
        },
      ),
    );
  }
}