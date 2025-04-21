// import 'package:fitness/widgets/circular_progress_painter.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// class ProgressCard extends StatelessWidget {
//   final double progress;
//   final int calories;
//   final String date;

//   const ProgressCard({
//     Key? key,
//     required this.progress,
//     required this.calories,
//     required this.date,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: const Color(0xFF5B6BF9),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: const [
//               Icon(Icons.track_changes, color: Colors.white, size: 18),
//               SizedBox(width: 8),
//               Text(
//                 'Your Progress',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '$progress%',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 80,
//                 width: 80,
//                 child: Stack(
//                   children: [
//                     CustomPaint(
//                       size: const Size(80, 80),
//                       painter: CircleProgressPainter(
//                         progress: progress / 100,
//                         backgroundColor: Colors.white.withOpacity(0.3),
//                         progressColor: Colors.white,
//                       ),
//                     ),
//                     Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             '$calories',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Text(
//                             'Calories',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 10,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             date,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:fitness/widgets/circular_progress_painter.dart';

// class ProgressCard extends StatelessWidget {
//   final double progress;
//   final int calories;
//   final String date;

//   const ProgressCard({
//     Key? key,
//     required this.progress,
//     required this.calories,
//     required this.date,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//           colors: [
//             Color(0xFF5B6BF9),
//             Color(0xFF9BA9FF), // Light bluish gradient
//           ],
//         ),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           /// Left Side - Text
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: const [
//                   Icon(Icons.track_changes, color: Colors.white, size: 18),
//                   SizedBox(width: 6),
//                   Text(
//                     'Your Progress',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 '${progress.toInt()}%',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 42,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 date,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),

//           /// Right Side - Circular Progress
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               // Outer circle
//               SizedBox(
//                 width: 100,
//                 height: 100,
//                 child: CustomPaint(
//                   painter: CircleProgressPainter(
//                     progress: progress / 100,
//                     progressColor: Colors.white,
//                     backgroundColor: Colors.white.withOpacity(0.3),
//                   ),
//                 ),
//               ),

//               // Inner circle with calorie info
//               Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   shape: BoxShape.circle,
//                 ),
//                 alignment: Alignment.center,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       '$calories',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Text(
//                       'Calories',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'dart:math' as math;

class SemiCircleProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  SemiCircleProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Define the start and end angles for a semi-circle 
    // Starting from right side (about 0.7 * PI) going counter-clockwise to the left side (about 2.3 * PI)
    const double startAngle = -math.pi * 0.3; // Start from right side
    const double endAngle = math.pi * 1.3;   // End at left side
    const double totalAngle = endAngle - startAngle;
    
    // Paint for the background arc
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    // Draw background arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      totalAngle,
      false,
      backgroundPaint,
    );
    
    // Paint for the progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    // Draw progress arc - start from right and progress counter-clockwise
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      totalAngle * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ProgressCard extends StatelessWidget {
  final double progress;
  final int calories;
  final String date;

  const ProgressCard({
    Key? key,
    required this.progress,
    required this.calories,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF5B6BF9),
            Color(0xFF9BA9FF), // Light bluish gradient
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Left Side - Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.track_changes, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Your Progress',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                '${progress.toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          /// Right Side - Semi-Circular Progress (larger)
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer semi-circle - made larger
              SizedBox(
                width: 120, // Increased from 100
                height: 120, // Increased from 100
                child: CustomPaint(
                  painter: SemiCircleProgressPainter(
                    progress: progress / 100,
                    progressColor: Colors.white,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    strokeWidth: 10, // Increased from 8
                  ),
                ),
              ),

              // Inner circle with calorie info - made larger
              Container(
                width: 80, // Increased from 60
                height: 80, // Increased from 60
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$calories',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18, // Increased from 14
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Calories',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12, // Increased from 10
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}