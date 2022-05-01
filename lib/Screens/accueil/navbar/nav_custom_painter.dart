import 'package:flutter/material.dart';

class NavCustomPainter extends CustomPainter {
   double loc;
   double s;
  Color color ;
  TextDirection textDirection;

  NavCustomPainter(
      double startingLoc,
      int itemsLength,
      this.color, //navbar bg color
      this.textDirection) {
    final span = 1.0 / itemsLength; // distance bin el curve wel icon
    s = 0.2; // width curve
    double l = startingLoc + (span - s) / 2; // position mta3 el curve par rapport icon
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill; // la partie blanche du navbar
// curve shape and size
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo((loc - 0.1) * size.width,0)
      //right side curve shape
      ..cubicTo(
        (loc + s * 0.20) * size.width,
        size.height * 0.05,
        loc * size.width,
        size.height * 0.60,
        (loc + s * 0.50) * size.width,
        size.height * 0.60,
      )
      //left side curve shape
      ..cubicTo(
        (loc + s) * size.width,
        size.height * 0.60,
        (loc + s - s * 0.20) * size.width,
        size.height * 0.05,
        (loc + s + 0.1) * size.width,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
