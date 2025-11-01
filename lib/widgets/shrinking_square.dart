import 'package:flutter/material.dart';

class ShrinkingSquare extends StatefulWidget {
  final double maxSize;
  final double minSize;
  final Duration duration;

  const ShrinkingSquare({
    Key? key,
    this.maxSize = 200,
    this.minSize = 40,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<ShrinkingSquare> createState() => _ShrinkingSquareState();
}

class _ShrinkingSquareState extends State<ShrinkingSquare> {
  double _size = 200;

  @override
  void initState() {
    super.initState();
    _size = widget.maxSize;
  }

  void _shrink() {
    setState(() {
      _size = (_size - 20).clamp(widget.minSize, widget.maxSize);
    });
  }

  void _grow() {
    setState(() {
      _size = (_size + 20).clamp(widget.minSize, widget.maxSize);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          width: _size,
          height: _size,
          duration: widget.duration,
          curve: Curves.easeInOut,
          child: GestureDetector(
            onTap: _shrink,
            child: Container(
              color: Colors.blueAccent,
              child: Center(
                child: Text(
                  '${_size.toInt()}',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _shrink, child: const Text('Shrink')),
            const SizedBox(width: 8),
            ElevatedButton(onPressed: _grow, child: const Text('Grow')),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          min: widget.minSize,
          max: widget.maxSize,
          value: _size,
          onChanged: (v) => setState(() => _size = v),
        )
      ],
    );
  }
}
