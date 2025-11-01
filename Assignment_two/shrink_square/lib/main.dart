import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment Two - Shrink Square',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:  Colors.deepOrange),
      ),
      home: const SquareShrink(title: 'Assignment Two - Shrink Square'),
    );
  }
}

class SquareShrink extends StatefulWidget {
  const SquareShrink({super.key, required this.title});
  final String title;

  @override
  State<SquareShrink> createState() => _SquareShrinkState();
}

class _SquareShrinkState extends State<SquareShrink> {
  double _size = 500;

  void _SquareShrinker() {
    setState(() {
      _size == 100 ? _size = 500 : _size -= 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: _size,
          height:_size,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _SquareShrinker,
        tooltip: _size==100 ? 'Restart' : 'Shrink',
        child: _size==100 ? Icon(Icons.add_circle) : Icon(Icons.cancel),
      ),
    );
  }
}
