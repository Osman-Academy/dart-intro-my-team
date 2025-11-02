import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShrinkingSquare(),
    );
  }
}

class ShrinkingSquare extends StatefulWidget {
  const ShrinkingSquare({super.key});

  @override
  State<ShrinkingSquare> createState() => _ShrinkingSquareState();
}

class _ShrinkingSquareState extends State<ShrinkingSquare> {
  double _size = 200;

  void _shrink() {
    setState(() {
      _size = _size > 50 ? _size - 20 : 200;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Dynamic Square Shrink'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: AnimatedContainer(
          width: _size,
          height: _size,
          color: Colors.tealAccent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _shrink,
        child: const Icon(Icons.remove),
      ),
    );
  }
}
