import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double size = 100;
  final TextEditingController controller = TextEditingController(text: "100");

  

  void changeSize(String value) {
    double? newSize = double.tryParse(value);
    if (newSize != null) {
      setState(() {
        size = newSize;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(width: size, height: size, color: Colors.pinkAccent),
          SizedBox(
          width: 200, 
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            onSubmitted: changeSize,
      ),
          ),]
      ),
    );
  }
}
