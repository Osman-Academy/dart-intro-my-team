import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: SquarePage());
}

class SquarePage extends StatefulWidget {
  const SquarePage({super.key});
  @override
  State<SquarePage> createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage> {
  double _size = 200;
  bool _small = false;

  void _toggle() {
    setState(() {
      _small = !_small;
      _size = _small ? 60 : 200;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic Square')),
      body: Center(
        child: GestureDetector(
          onTap: _toggle,
          child: AnimatedContainer(
            width: _size,
            height: _size,
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeInOut,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        child: const Icon(Icons.sync),
      ),
    );
  }
}
