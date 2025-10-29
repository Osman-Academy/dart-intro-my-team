import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ShrinkSquare());
  }
}

class ShrinkSquare extends StatefulWidget {
  const ShrinkSquare({super.key});

  @override
  State<ShrinkSquare> createState() => _ShrinkSquareState();
}

class _ShrinkSquareState extends State<ShrinkSquare> {
  double size = 200;

  void shrink() {
    setState(() {
      size = size > 50 ? size - 20 : 200; // shrink until 50 then reset
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: shrink,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: size,
            height: size,
            color: Colors.blue,
            child: const Center(
                child: Text("Tap me", style: TextStyle(color: Colors.white))),
          ),
        ),
      ),
    );
  }
}
