import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DynamicSquarePage(),
    );
  }
}

class DynamicSquarePage extends StatefulWidget {
  const DynamicSquarePage({super.key});

  @override
  State<DynamicSquarePage> createState() => _DynamicSquarePageState();
}

class _DynamicSquarePageState extends State<DynamicSquarePage> {
  double _size = 200; // начальный размер квадрата

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _size,
              height: _size,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 30),
          Slider(
            value: _size,
            min: 50,
            max: 350,
            divisions: 30,
            label: "${_size.round()} px",
            onChanged: (value) {
              setState(() {
                _size = value;
              });
            },
          ),
          const SizedBox(height: 10),
          Text(
            "Size: ${_size.toStringAsFixed(0)} px",
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
