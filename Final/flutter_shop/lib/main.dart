import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final res = await http.get(Uri.parse('https://dummyjson.com/test'));
  final data = jsonDecode(res.body);
  runApp(MainApp(data: data));
}

class MainApp extends StatelessWidget {
  final dynamic data;
  
  const MainApp({super.key, required this.data});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(data.toString()),
        ),
      ),
    );
  }
}
