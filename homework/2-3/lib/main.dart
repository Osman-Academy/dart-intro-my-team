import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homework/pages/square.dart';
import 'package:homework/pages/repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hello World',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        "/home": (context) => Scaffold(
              appBar: AppBar(
                title: Text("Home"),
              ),
              body: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () => Navigator.pushNamed(context, '/square'),
                    child: Text("Square",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    color: Colors.blue,
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () => Navigator.pushNamed(context, '/repo'),
                    child: Text("Repository",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    color: Colors.blue,
                  )
                ],
              )),
            ),
        "/square": (context) => Square(),
        "/repo": (context) => AuthRepoDemo(),
      },
    );
  }
}
