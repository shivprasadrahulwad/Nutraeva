import 'package:flutter/material.dart';

class CurvedFramingGuidePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    const double cornerRadius = 15.0;
    const double arcLength = 30.0;

    // Top-left corner
    canvas.drawArc(
      Rect.fromLTWH(0, 0, cornerRadius * 2, cornerRadius * 2),
      3.14, // 180°
      1.57, // 90°
      false,
      paint,
    );

    // Top-right corner
    canvas.drawArc(
      Rect.fromLTWH(size.width - cornerRadius * 2, 0, cornerRadius * 2, cornerRadius * 2),
      4.71, // 270°
      1.57, // 90°
      false,
      paint,
    );

    // Bottom-right corner
    canvas.drawArc(
      Rect.fromLTWH(size.width - cornerRadius * 2, size.height - cornerRadius * 2, cornerRadius * 2, cornerRadius * 2),
      0, // 0°
      1.57, // 90°
      false,
      paint,
    );

    // Bottom-left corner
    canvas.drawArc(
      Rect.fromLTWH(0, size.height - cornerRadius * 2, cornerRadius * 2, cornerRadius * 2),
      1.57, // 90°
      1.57, // 90°
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}