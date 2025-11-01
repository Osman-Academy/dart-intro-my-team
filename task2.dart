// task2.dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShrinkingSquarePage(),
    );
  }
}

class ShrinkingSquarePage extends StatefulWidget {
  const ShrinkingSquarePage({super.key});
  @override
  State<ShrinkingSquarePage> createState() => _ShrinkingSquarePageState();
}

class _ShrinkingSquarePageState extends State<ShrinkingSquarePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnim;
  double maxSize = 220;
  double minSize = 20;
  double durationSec = 4.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (durationSec * 1000).toInt()),
    );
    _sizeAnim = Tween(begin: maxSize, end: minSize).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() => setState(() {}));
  }

  void _updateAnimation() {
    _controller.duration = Duration(milliseconds: (durationSec * 1000).toInt());
    _sizeAnim = Tween(begin: maxSize, end: minSize).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _controls() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Duration: ${durationSec.toStringAsFixed(1)}s'),
        Slider(
          value: durationSec,
          min: 0.5,
          max: 10,
          divisions: 95,
          label: durationSec.toStringAsFixed(1),
          onChanged: (v) {
            setState(() {
              durationSec = v;
              _updateAnimation();
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _controller.forward(from: 0);
              },
              child: const Text('Shrink'),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {
                if (_controller.status == AnimationStatus.forward ||
                    _controller.status == AnimationStatus.completed) {
                  _controller.reverse();
                } else {
                  _controller.forward();
                }
              },
              child: const Text('Toggle'),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {
                _controller.reset();
              },
              child: const Text('Reset'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Auto-pulse:'),
            Switch(
              value: _controller.isAnimating && _controller.status == AnimationStatus.forward,
              onChanged: (v) {
                if (v) {
                  _controller.repeat(reverse: true);
                } else {
                  _controller.stop();
                }
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double currentSize = _sizeAnim.value;
    double area = currentSize * currentSize;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Shrinking Square'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (_controller.status == AnimationStatus.dismissed ||
                      _controller.status == AnimationStatus.reverse) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                },
                child: Container(
                  width: currentSize,
                  height: currentSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${area.toStringAsFixed(0)} px²',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _controls(),
            ],
          ),
        ),
      ),
    );
  }
}
