// Custom painter for macro ratio visualization
import 'package:flutter/material.dart';

class MacroBarPainter extends CustomPainter {
  final double proteins;
  final double carbs;
  final double fats;

  MacroBarPainter({
    required this.proteins,
    required this.carbs,
    required this.fats,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double total = proteins + carbs + fats;

    // If there's no data or all zeros, draw empty bars
    if (total <= 0) {
      _drawEmptyBars(canvas, size);
      return;
    }

    final double proteinWidth = (proteins / total) * size.width;
    final double carbWidth = (carbs / total) * size.width;
    final double fatWidth = (fats / total) * size.width;

    final double height = size.height * 0.6;
    final double top = (size.height - height) / 2;

    // Draw protein bar
    final paintProtein = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, top, proteinWidth, height),
        const Radius.circular(8),
      ),
      paintProtein,
    );

    // Draw carb bar
    final paintCarb = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(proteinWidth, top, carbWidth, height),
        const Radius.circular(8),
      ),
      paintCarb,
    );

    // Draw fat bar
    final paintFat = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(proteinWidth + carbWidth, top, fatWidth, height),
        const Radius.circular(8),
      ),
      paintFat,
    );

    // Draw percentages if there's enough space
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );

    if (proteinWidth > 30) {
      _drawTextCentered(
        canvas,
        '${(proteins / total * 100).toStringAsFixed(0)}%',
        textStyle,
        Offset(proteinWidth / 2, size.height / 2),
      );
    }

    if (carbWidth > 30) {
      _drawTextCentered(
        canvas,
        '${(carbs / total * 100).toStringAsFixed(0)}%',
        textStyle,
        Offset(proteinWidth + carbWidth / 2, size.height / 2),
      );
    }

    if (fatWidth > 30) {
      _drawTextCentered(
        canvas,
        '${(fats / total * 100).toStringAsFixed(0)}%',
        textStyle,
        Offset(proteinWidth + carbWidth + fatWidth / 2, size.height / 2),
      );
    }
  }

  void _drawEmptyBars(Canvas canvas, Size size) {
    final double height = size.height * 0.6;
    final double top = (size.height - height) / 2;

    final paint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, top, size.width, height),
        const Radius.circular(8),
      ),
      paint,
    );

    // Draw "No data" text
    final textStyle = TextStyle(
      color: Colors.grey[600],
      fontSize: 14,
    );

    _drawTextCentered(
      canvas,
      'No nutritional data',
      textStyle,
      Offset(size.width / 2, size.height / 2),
    );
  }

  void _drawTextCentered(
      Canvas canvas, String text, TextStyle style, Offset position) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final dx = position.dx - textPainter.width / 2;
    final dy = position.dy - textPainter.height / 2;
    textPainter.paint(canvas, Offset(dx, dy));
  }

  @override
  bool shouldRepaint(MacroBarPainter oldDelegate) {
    return oldDelegate.proteins != proteins ||
        oldDelegate.carbs != carbs ||
        oldDelegate.fats != fats;
  }
}

