import 'dart:math';

import 'package:fitness/server/models/barData.dart';
import 'package:flutter/material.dart';

// class WeeklyBarGraph extends StatelessWidget {
//   final List<BarData> data;
//   final double barWidth;
//   final double spacing;
//   final Color defaultBarColor;
//   final double maxHeight;

//   const WeeklyBarGraph({
//     super.key,
//     required this.data,
//     this.barWidth = 30.0,
//     this.spacing = 12.0,
//     this.defaultBarColor = Colors.blue,
//     this.maxHeight = 200.0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Find the maximum value to scale the bars
//     double maxValue = data.fold(0, (max, item) => item.value > max ? item.value : max);
    
//     return Column(
//       children: [
//         const Text(
//           'Weekly Activity',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 20),
//         SizedBox(
//           height: maxHeight + 40, // Extra space for labels
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: data.map((item) {
//               // Calculate height as a percentage of the maximum height
//               final barHeight = maxValue > 0 
//                   ? (item.value / maxValue) * maxHeight 
//                   : 0.0;
              
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: spacing / 2),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Value label
//                     Text(
//                       item.value.toString(),
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     // Bar
//                     Container(
//                       width: barWidth,
//                       height: barHeight,
//                       decoration: BoxDecoration(
//                         color: item.color ?? defaultBarColor,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     // Day label
//                     Text(
//                       item.day,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }



// class WeeklyBarGraph extends StatelessWidget {
//   final List<BarData> data;
//   final double barWidth;
//   final double spacing;
//   final Color defaultBarColor;
//   final double maxHeight;

//   const WeeklyBarGraph({
//     super.key,
//     required this.data,
//     this.barWidth = 35.0,
//     this.spacing = 14.0,
//     this.defaultBarColor = Colors.blue,
//     this.maxHeight = 180.0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Find the maximum value to scale the bars
//     double maxValue = data.fold(0, (max, item) => item.value > max ? item.value : max);
    
//     return Column(
//       mainAxisSize: MainAxisSize.min, // Fixed: Use minimum vertical space
//       children: [
//         const Text(
//           'Weekly Activity',
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF2B2D42),
//           ),
//         ),
//         const SizedBox(height: 8),
//         const Text(
//           'Activity distribution from Monday to Sunday',
//           style: TextStyle(
//             fontSize: 12,
//             color: Color(0xFF8D99AE),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 24),
//         Container(
//           height: maxHeight + 50, // Extra space for labels
//           child: SingleChildScrollView( // Fixed: Make it scrollable if needed
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: data.map((item) {
//                 // Calculate height as a percentage of the maximum height
//                 final barHeight = maxValue > 0 
//                     ? (item.value / maxValue) * maxHeight 
//                     : 0.0;
                
//                 return Padding(
//                   padding: EdgeInsets.symmetric(horizontal: spacing / 2),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Value label
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Text(
//                           item.value.toString(),
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             color: item.color ?? defaultBarColor,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       // Bar with background track
//                       Stack(
//                         alignment: Alignment.bottomCenter,
//                         children: [
//                           // Background track
//                           Container(
//                             width: barWidth,
//                             height: maxHeight,
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade200,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           // Actual bar
//                           Container(
//                             width: barWidth,
//                             height: barHeight,
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   (item.color ?? defaultBarColor).withOpacity(0.9),
//                                   (item.color ?? defaultBarColor),
//                                 ],
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: (item.color ?? defaultBarColor).withOpacity(0.3),
//                                   blurRadius: 8,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       // Day label with container
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: Text(
//                           item.day,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 13,
//                             color: Color(0xFF2B2D42),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }



class WeeklyBarGraph extends StatelessWidget {
  final List<BarData> data;
  final double barWidth;
  final double spacing;
  final Color defaultBarColor;
  final double maxHeight;

  const WeeklyBarGraph({
    super.key,
    required this.data,
    this.barWidth = 35.0,
    this.spacing = 14.0,
    this.defaultBarColor = Colors.blue,
    this.maxHeight = 180.0,
  });

  @override
  Widget build(BuildContext context) {
    // Find the maximum value to scale the bars
    double maxValue = data.fold(0, (max, item) => item.value > max ? item.value : max);
    
    return Column(
      mainAxisSize: MainAxisSize.min, // Use minimum vertical space
      children: [
        const Text(
          'Weekly Activity',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2B2D42),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Activity distribution from Monday to Sunday',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF8D99AE),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        // Wrap with Expanded and LayoutBuilder to handle constraints properly
        Flexible(
          fit: FlexFit.loose,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Calculate available height for the chart
              final availableHeight = constraints.maxHeight - 50; // Subtract space for labels
              final chartHeight = availableHeight > 0 ? min(maxHeight, availableHeight) : maxHeight;
              
              return Container(
                height: chartHeight + 50, // Adjusted height
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: data.map((item) {
                      // Calculate height as a percentage of the maximum height
                      final barHeight = maxValue > 0 
                          ? (item.value / maxValue) * chartHeight 
                          : 0.0;
                      
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: spacing / 2),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Value label
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                item.value.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: item.color ?? defaultBarColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Bar with background track
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                // Background track
                                Container(
                                  width: barWidth,
                                  height: chartHeight,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                // Actual bar
                                Container(
                                  width: barWidth,
                                  height: barHeight,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        (item.color ?? defaultBarColor).withOpacity(0.9),
                                        (item.color ?? defaultBarColor),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: (item.color ?? defaultBarColor).withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Day label with container
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item.day,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Color(0xFF2B2D42),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}