import 'package:flutter/material.dart';

void main() {
  runApp(const ShrinkingSquareApp());
}

class ShrinkingSquareApp extends StatefulWidget {
  const ShrinkingSquareApp({super.key});

  @override
  State<ShrinkingSquareApp> createState() => _ShrinkingSquareAppState();
}

class _ShrinkingSquareAppState extends State<ShrinkingSquareApp> {
  double _size = 200;

  void _shrinkSquare() {
    setState(() {
      if (_size > 50) _size -= 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Dynamic Shrinking Square")),
        body: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _size,
            height: _size,
            color: Colors.blue,
            child: const Center(
              child: Text("Tap to Shrink", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _shrinkSquare,
          child: const Icon(Icons.remove),
        ),
      ),
    );
  }
}
