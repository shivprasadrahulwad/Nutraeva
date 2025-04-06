import 'dart:ui';

class BarData {
  final String day;
  final double value;
  final Color? color;

  BarData({
    required this.day,
    required this.value,
    this.color,
  });
}