import 'package:flutter/material.dart';
import 'dart:math' as math;

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gapSize;

  DashedCirclePainter({
    required this.color,
    this.strokeWidth = 2,
    this.gapSize = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = (size.width / 2) - strokeWidth / 2;
    const int dashCount = 20;
    final double gapRadians = (2 * math.pi) / dashCount;

    for (int i = 0; i < dashCount; i += 2) {
      final double startAngle = i * gapRadians;
      final double sweepAngle = gapRadians;
      canvas.drawArc(
        Rect.fromCircle(center: size.center(Offset.zero), radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
