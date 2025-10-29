import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SquareDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SquareDemo extends StatefulWidget {
  const SquareDemo({super.key});
  @override
  State<SquareDemo> createState() => _SquareDemoState();
}

class _SquareDemoState extends State<SquareDemo> {
  double _size = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dynamic Square")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: _size,
              height: _size,
              color: const Color.fromARGB(255, 142, 17, 245),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            ),
            const SizedBox(height: 20),
            Slider(
              value: _size,
              min: 50,
              max: 300,
              onChanged: (value) {
                setState(() => _size = value);
              },
            ),
            Text('Size: ${_size.toStringAsFixed(0)}'),
          ],
        ),
      ),
    );
  }
}
