import 'package:flutter/material.dart';

class CubePainter extends CustomPainter {
  final double size;

  CubePainter(this.size);

  @override
  void paint(Canvas canvas, Size s) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double scale = size * 10;

    canvas.drawRect(Rect.fromLTWH(0, 0, scale, scale), paint);

    double shift = scale * 0.3;

    canvas.drawRect(Rect.fromLTWH(shift, shift, scale, scale), paint);

    canvas.drawLine(Offset(0, 0), Offset(shift, shift), paint);
    canvas.drawLine(Offset(scale, 0), Offset(scale + shift, shift), paint);
    canvas.drawLine(Offset(0, scale), Offset(shift, scale + shift), paint);
    canvas.drawLine(Offset(scale, scale),
        Offset(scale + shift, scale + shift), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
