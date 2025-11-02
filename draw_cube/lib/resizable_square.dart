import 'package:flutter/material.dart';

class ResizableSquare extends StatefulWidget {
  const ResizableSquare({super.key});

  @override
  State<ResizableSquare> createState() => _ResizableSquareState();
}

class _ResizableSquareState extends State<ResizableSquare> {
  double _size = 200;

  void _shrink() {
    setState(() {
      _size = (_size - 30).clamp(50, 400);
    });
  }

  void _grow() {
    setState(() {
      _size = (_size + 30).clamp(50, 400);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          width: _size,
          height: _size,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            '${_size.toStringAsFixed(0)} px',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _shrink, child: const Text('Shrink')),
            const SizedBox(width: 10),
            ElevatedButton(onPressed: _grow, child: const Text('Grow')),
          ],
        ),
      ],
    );
  }
}
