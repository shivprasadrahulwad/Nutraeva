
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const NotificationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: Colors.grey[50],
  elevation: 0,
  leading: Container(
    margin: const EdgeInsets.only(left: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      padding: EdgeInsets.zero,
      onPressed: () {},
    ),
  ),
  centerTitle: true,
  title: const Text(
    'Notification',
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
  ),
  actions: [
    Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.tune, color: Colors.black),
        padding: EdgeInsets.zero,
        onPressed: () {},
      ),
    ),
  ],
),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SectionHeader(title: 'Today'),
          NotificationItem(
            icon: Icons.credit_card,
            title: 'Add your card or account',
            subtitle: 'Add your card now for quick, seamless payments',
          ),
          NotificationItem(
            icon: Icons.not_interested,
            title: 'Service will not be available at this time',
            subtitle: 'Sorry, the service is unavailable at the moment',
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: 'Yesterday'),
          NotificationItem(
            icon: Icons.sentiment_satisfied_alt_outlined,
            title: 'Good news for you',
            subtitle: 'Get ready for new features and exclusives!',
          ),
          NotificationItem(
            icon: Icons.access_time,
            title: 'Drink water reminder',
            subtitle: 'Time to Stay refreshed and keep your energy up',
          ),
          NotificationItem(
            icon: Icons.settings,
            title: 'Time to log your exercise',
            subtitle: 'Time to log it and track your progress.',
          ),
          NotificationItem(
            icon: Icons.brightness_1_outlined,
            title: 'Progress Updates',
            subtitle: 'Congrats on hitting your goal today!',
          ),
          NotificationItem(
            icon: Icons.emoji_events_outlined,
            title: 'Goal Achievement',
            subtitle: 'Amazing job hitting your calorie target today!',
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const NotificationItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}