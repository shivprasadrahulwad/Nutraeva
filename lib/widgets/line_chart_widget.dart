// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;

// class GradientLineChart extends StatelessWidget {
//   final List<DataPoint> dataPoints;
//   final int highlightedPointIndex;
//   final double height;
//   final double width;
//   final Color lineColor;
//   final List<Color> gradientColors;

//   const GradientLineChart({
//     super.key,
//     required this.dataPoints,
//     this.highlightedPointIndex = 4, // Default to May (index 4)
//     this.height = 300.0,
//     this.width = double.infinity,
//     this.lineColor = const Color(0xFF9D50BB),
//     this.gradientColors = const [
//       Color(0xFF9D50BB),
//       Color(0xFFC8A8E9),
//       Colors.white,
//     ],
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Stack(
//         children: [
//           CustomPaint(
//             size: Size(width, height),
//             painter: _LineChartPainter(
//               dataPoints: dataPoints,
//               lineColor: lineColor,
//               gradientColors: gradientColors,
//             ),
//           ),
//           if (highlightedPointIndex >= 0 && highlightedPointIndex < dataPoints.length)
//             Positioned(
//               left: dataPoints[highlightedPointIndex].x * width,
//               top: dataPoints[highlightedPointIndex].y * (height * 0.7),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 20,
//                     height: 20,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: lineColor,
//                         width: 3,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: height * 0.3 - 20, // Extend to bottom
//                     width: 2,
//                     color: lineColor.withOpacity(0.3),
//                   ),
//                 ],
//               ),
//             ),
//           // Month labels at bottom
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   for (int i = 0; i < dataPoints.length; i++)
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                       decoration: BoxDecoration(
//                         color: i == highlightedPointIndex
//                             ? lineColor
//                             : Colors.transparent,
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Text(
//                         _getMonthName(i),
//                         style: TextStyle(
//                           color: i == highlightedPointIndex ? Colors.white : Colors.grey,
//                           fontWeight: i == highlightedPointIndex
//                               ? FontWeight.bold
//                               : FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getMonthName(int index) {
//     const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];
//     return months[index % months.length];
//   }
// }

// class DataPoint {
//   final double x;
//   final double y; 

//   DataPoint(this.x, this.y);
// }

// class _LineChartPainter extends CustomPainter {
//   final List<DataPoint> dataPoints;
//   final Color lineColor;
//   final List<Color> gradientColors;

//   _LineChartPainter({
//     required this.dataPoints,
//     required this.lineColor,
//     required this.gradientColors,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final linePaint = Paint()
//       ..color = lineColor
//       ..strokeWidth = 3.0
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     // Create path for the line
//     final path = Path();
    
//     if (dataPoints.isEmpty) return;
    
//     // Move to the first point
//     path.moveTo(
//       dataPoints[0].x * size.width,
//       dataPoints[0].y * size.height * 0.7, // Using 70% of height for chart
//     );
    
//     // Create smooth curve through all points
//     for (int i = 0; i < dataPoints.length - 1; i++) {
//       final p1 = Offset(
//         dataPoints[i].x * size.width,
//         dataPoints[i].y * size.height * 0.7,
//       );
      
//       final p2 = Offset(
//         dataPoints[i + 1].x * size.width,
//         dataPoints[i + 1].y * size.height * 0.7,
//       );
      
//       // Control points for smoother curve
//       final controlPoint1 = Offset(
//         p1.dx + (p2.dx - p1.dx) / 2,
//         p1.dy,
//       );
      
//       final controlPoint2 = Offset(
//         p1.dx + (p2.dx - p1.dx) / 2,
//         p2.dy,
//       );
      
//       path.cubicTo(
//         controlPoint1.dx, controlPoint1.dy,
//         controlPoint2.dx, controlPoint2.dy,
//         p2.dx, p2.dy,
//       );
//     }
    
//     // Draw the line
//     canvas.drawPath(path, linePaint);
    
//     // Create gradient fill
//     final fillPath = Path.from(path);
//     fillPath.lineTo(size.width, size.height * 0.7); // Bottom right
//     fillPath.lineTo(0, size.height * 0.7); // Bottom left
//     fillPath.close();
    
//     // Create gradient for fill
//     final gradient = ui.Gradient.linear(
//       Offset(size.width / 2, 0),
//       Offset(size.width / 2, size.height * 0.7),
//       gradientColors,
//       [0.0, 0.7, 1.0],
//     );
    
//     final fillPaint = Paint()
//       ..shader = gradient
//       ..style = PaintingStyle.fill;
    
//     canvas.drawPath(fillPath, fillPaint);
//   }

//   @override
//   bool shouldRepaint(_LineChartPainter oldDelegate) => 
//       oldDelegate.dataPoints != dataPoints ||
//       oldDelegate.lineColor != lineColor ||
//       oldDelegate.gradientColors != gradientColors;
// }






import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class GradientLineChart extends StatelessWidget {
  final List<DataPoint> dataPoints;
  final int highlightedPointIndex;
  final double height;
  final double width;
  final Color lineColor;
  final List<Color> gradientColors;

  const GradientLineChart({
    super.key,
    required this.dataPoints,
    this.highlightedPointIndex = 2, // Default to May (index 4)
    this.height = 300.0,
    this.width = double.infinity,
    this.lineColor = const Color(0xFF9D50BB),
    this.gradientColors = const [
      Color(0xFF9D50BB),
      Color(0xFFC8A8E9),
      Colors.white,
    ],
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use actual available width instead of potentially infinite width
        final actualWidth = constraints.maxWidth;
        final actualHeight = height;
        final chartHeight = actualHeight * 0.7; // 70% for chart
        final labelsHeight = actualHeight * 0.3; // 30% for labels
        
        return Container(
          height: actualHeight,
          width: actualWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              // Draw chart area
              Positioned.fill(
                bottom: labelsHeight, // Leave space for labels
                child: CustomPaint(
                  painter: _LineChartPainter(
                    dataPoints: dataPoints,
                    lineColor: lineColor,
                    gradientColors: gradientColors,
                    chartHeight: chartHeight,
                  ),
                ),
              ),
              
              // Vertical indicator line
              if (highlightedPointIndex >= 0 && highlightedPointIndex < dataPoints.length)
                Positioned(
                  left: (dataPoints[highlightedPointIndex].x * actualWidth).clamp(0, actualWidth),
                  top: 0,
                  child: Container(
                    width: 2,
                    height: chartHeight,
                    color: lineColor.withOpacity(0.3),
                  ),
                ),
              
              // Highlighted point dot
              if (highlightedPointIndex >= 0 && highlightedPointIndex < dataPoints.length)
                Positioned(
                  left: (dataPoints[highlightedPointIndex].x * actualWidth - 10).clamp(0, actualWidth - 20),
                  top: (dataPoints[highlightedPointIndex].y * chartHeight - 10).clamp(0, chartHeight - 20),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: lineColor,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              
              // Month labels at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: labelsHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    dataPoints.length,
                    (i) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: i == highlightedPointIndex
                            ? lineColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        _getMonthName(i),
                        style: TextStyle(
                          color: i == highlightedPointIndex ? Colors.white : Colors.grey,
                          fontWeight: i == highlightedPointIndex
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  String _getMonthName(int index) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];
    return months[index % months.length];
  }
}

class DataPoint {
  final double x; // normalized x position (0.0 to 1.0)
  final double y; // normalized y position (0.0 to 1.0)

  DataPoint(this.x, this.y);
}

class _LineChartPainter extends CustomPainter {
  final List<DataPoint> dataPoints;
  final Color lineColor;
  final List<Color> gradientColors;
  final double chartHeight;

  _LineChartPainter({
    required this.dataPoints,
    required this.lineColor,
    required this.gradientColors,
    required this.chartHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.isEmpty || size.width <= 0 || size.height <= 0) {
      return; // Don't paint if we have invalid dimensions
    }

    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Create path for the line
    final path = Path();
    
    // Move to the first point
    final firstX = (dataPoints[0].x * size.width).clamp(0.0, size.width);
    final firstY = (dataPoints[0].y * chartHeight).clamp(0.0, chartHeight);
    path.moveTo(firstX, firstY);
    
    // Create smooth curve through all points
    for (int i = 0; i < dataPoints.length - 1; i++) {
      final p1x = (dataPoints[i].x * size.width).clamp(0.0, size.width);
      final p1y = (dataPoints[i].y * chartHeight).clamp(0.0, chartHeight);
      final p1 = Offset(p1x, p1y);
      
      final p2x = (dataPoints[i + 1].x * size.width).clamp(0.0, size.width);
      final p2y = (dataPoints[i + 1].y * chartHeight).clamp(0.0, chartHeight);
      final p2 = Offset(p2x, p2y);
      
      // Control points for smoother curve - ensure they're valid
      final midX = (p1.dx + p2.dx) / 2;
      if (midX.isFinite) { // Check if midX is valid
        final controlPoint1 = Offset(midX, p1.dy);
        final controlPoint2 = Offset(midX, p2.dy);
        
        path.cubicTo(
          controlPoint1.dx, controlPoint1.dy,
          controlPoint2.dx, controlPoint2.dy,
          p2.dx, p2.dy,
        );
      } else {
        // Fallback to simple line if cubic control points would be invalid
        path.lineTo(p2.dx, p2.dy);
      }
    }
    
    // Draw the line
    canvas.drawPath(path, linePaint);
    
    // Create gradient fill
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, chartHeight); // Bottom right
    fillPath.lineTo(0, chartHeight); // Bottom left
    fillPath.close();
    
    // Create gradient for fill - ensure points are valid
    final gradient = ui.Gradient.linear(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, chartHeight),
      gradientColors,
      [0.0, 0.7, 1.0],
    );
    
    final fillPaint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(_LineChartPainter oldDelegate) => 
      oldDelegate.dataPoints != dataPoints ||
      oldDelegate.lineColor != lineColor ||
      oldDelegate.gradientColors != gradientColors;
}