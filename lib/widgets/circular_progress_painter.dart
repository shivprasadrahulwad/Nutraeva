import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  CircleProgressPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2);
    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircleProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}