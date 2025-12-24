
import 'package:flutter/material.dart';

class ShrinkingSquareDemo extends StatefulWidget {
  const ShrinkingSquareDemo({Key? key}) : super(key: key);

  @override
  State<ShrinkingSquareDemo> createState() => _ShrinkingSquareDemoState();
}

class _ShrinkingSquareDemoState extends State<ShrinkingSquareDemo> {
  double _size = 200.0;
  static const double _minSize = 40.0;
  static const double _maxSize = 300.0;
  static const Duration _duration = Duration(milliseconds: 400);

  void _shrink() {
    setState(() {
      _size = (_size - 30).clamp(_minSize, _maxSize);
    });
  }

  void _grow() {
    setState(() {
      _size = (_size + 30).clamp(_minSize, _maxSize);
    });
  }

  void _autoShrink() {
    
    Future.doWhile(() async {
      await Future.delayed(_duration);
      if (_size <= _minSize) return false;
      setState(() => _size = (_size - 20).clamp(_minSize, _maxSize));
      return _size > _minSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shrinking Square Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Size: ${_size.toStringAsFixed(0)} px'),
            const SizedBox(height: 12),
            Center(
              child: AnimatedContainer(
                width: _size,
                height: _size,
                duration: _duration,
                curve: Curves.easeInOut,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(blurRadius: 8, offset: Offset(0,4), color: Colors.black26)],
                  ),
                  child: Text('Square', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Slider(
              min: _minSize,
              max: _maxSize,
              value: _size,
              onChanged: (v) => setState(() => _size = v),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton(onPressed: _shrink, child: const Text('Shrink')),
                ElevatedButton(onPressed: _grow, child: const Text('Grow')),
                ElevatedButton(onPressed: _autoShrink, child: const Text('Auto Shrink')),
                ElevatedButton(onPressed: () => setState(()=>_size=200), child: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Try: press Shrink repeatedly or use slider.'),
          ],
        ),
      ),
    );
  }
}
