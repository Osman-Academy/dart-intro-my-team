import 'package:flutter/material.dart';

class CubePainter extends CustomPainter {
  final double size;

  CubePainter(this.size);

  @override
  void paint(Canvas canvas, Size s) {
    final frontPaint = Paint()
      ..color = Colors.blue.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final sidePaint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.blue.shade900
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double scale = size * 10;
    double shift = scale * 0.3;

    // Back face (darker)
    canvas.drawRect(Rect.fromLTWH(0, 0, scale, scale), frontPaint);

    // Front face (lighter)
    canvas.drawRect(Rect.fromLTWH(shift, shift, scale, scale), sidePaint);

    // Connecting lines
    canvas.drawLine(Offset(0, 0), Offset(shift, shift), linePaint);
    canvas.drawLine(Offset(scale, 0), Offset(scale + shift, shift), linePaint);
    canvas.drawLine(Offset(0, scale), Offset(shift, scale + shift), linePaint);
    canvas.drawLine(
        Offset(scale, scale), Offset(scale + shift, scale + shift), linePaint);

    // Add size label
    final textPainter = TextPainter(
      text: TextSpan(
        text: size.toStringAsFixed(1),
        style: TextStyle(
          color: Colors.blue.shade900,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(shift + 5, shift + 5));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
