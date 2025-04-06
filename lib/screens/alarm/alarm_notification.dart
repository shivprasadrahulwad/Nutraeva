// import 'package:alarm/alarm.dart';
// import 'package:alarm/model/alarm_settings.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class AlarmNotificationScreen extends StatefulWidget {
//   final AlarmSettings alarmSettings;
  
//   const AlarmNotificationScreen({super.key, required this.alarmSettings});
  
//   @override
//   State<AlarmNotificationScreen> createState() => _AlarmNotificationScreenState();
// }

// class _AlarmNotificationScreenState extends State<AlarmNotificationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text("Alarm is ringing......."),
//           Text(widget.alarmSettings.notificationSettings.title ?? ""),
//           Text(widget.alarmSettings.notificationSettings.body ?? ""),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   //skip alarm for next time
//                   final now = DateTime.now();
//                   Alarm.set(
//                     alarmSettings: widget.alarmSettings.copyWith(
//                       dateTime: DateTime(
//                         now.year,
//                         now.month,
//                         now.day,
//                         now.hour,
//                         now.minute,
//                       ).add(const Duration(minutes: 1)),
//                     ),
//                   ).then((_) => Navigator.pop(context));
//                 },
//                 child: const Text("Snooze")
//               ),
//               const SizedBox(width: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   //stop alarm
//                   Alarm.stop(widget.alarmSettings.id)
//                     .then((_) => Navigator.pop(context));
//                 },
//                 child: const Text("Stop")
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }