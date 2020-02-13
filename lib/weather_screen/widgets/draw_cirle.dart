import 'package:flutter/material.dart';

class DrawCircle extends CustomPainter {
  Paint _paint;
  double _radius;

  DrawCircle(Color color, double radius) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
    _radius = radius;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), _radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}