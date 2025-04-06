// import 'dart:async';
// import 'dart:io';

// import 'package:alarm/alarm.dart';
// import 'package:alarm/model/alarm_settings.dart';
// import 'package:alarm/model/volume_settings.dart'; // Add this import
// import 'package:alarm/model/notification_settings.dart'; // Add this import
// import 'package:fitness/contants/screens/alarm/alarm_notification.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
  
//   final String title;
  
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late List<AlarmSettings> alarms = [];
  
//   static StreamSubscription<AlarmSettings>? subscription;
  
//   @override
//   void initState() {
//     super.initState();
//     //notification permission
//     checkAndroidNotificationPermission();
//     //schedule alarm permission
//     checkAndroidScheduleExactAlarmPermission();
//     loadAlarms();
//     subscription ??= Alarm.ringStream.stream.listen(navigateToRingScreen);
//     //listen alarm if active than navigate to alarm screen
//   }
  
//   Future<void> loadAlarms() async {
//     final loadedAlarms = await Alarm.getAlarms();
//     setState(() {
//       alarms = loadedAlarms;
//       alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
//     });
//   }
  
//   Future<void> checkAndroidNotificationPermission() async {
//     final status = await Permission.notification.status;
//     if (status.isDenied) {
//       if (kDebugMode) {
//         print('Requesting notification permission...');
//       }
//       final res = await Permission.notification.request();
//       if (kDebugMode) {
//         print('Notification permission ${res.isGranted ? '' : 'not '}granted');
//       }
//     }
//   }
  
//   Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute<void>(
//         builder: (context) => AlarmNotificationScreen(alarmSettings: alarmSettings),
//       ),
//     );
//     loadAlarms();
//   }
  
//   Future<void> checkAndroidScheduleExactAlarmPermission() async {
//     final status = await Permission.scheduleExactAlarm.status;
//     if (kDebugMode) {
//       print('Schedule exact alarm permission: $status.');
//     }
//     if (status.isDenied) {
//       if (kDebugMode) {
//         print('Requesting schedule exact alarm permission...');
//       }
//       final res = await Permission.scheduleExactAlarm.request();
//       if (kDebugMode) {
//         print('Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.');
//       }
//     }
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: ListView(
//         children: List.generate(
//           alarms.length,
//           (index) => ListTile(
//             title: Text(alarms[index].dateTime.toString()),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           var alarmDateTime = DateTime.now().add(const Duration(seconds: 30));
//           final alarmSettings = AlarmSettings(
//             id: 42,
//             dateTime: alarmDateTime,
//             assetAudioPath: 'assets/blank.mp3',
//             loopAudio: true,
//             vibrate: true,
// volumeSettings: VolumeSettings.fade(
//   fadeDuration: const Duration(seconds: 3),
//   volume: 0.8,
// ),
//             notificationSettings: NotificationSettings(
//               title: 'This is the title',
//               body: 'This is the body',
//             ),
//           );
          
//           await Alarm.set(alarmSettings: alarmSettings);
//           loadAlarms();
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }