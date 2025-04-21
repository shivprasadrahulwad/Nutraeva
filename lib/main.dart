import 'package:fitness/screens/analytics/analytics_screen.dart';
import 'package:fitness/screens/analytics/sleep_analytics_screen.dart';
import 'package:fitness/screens/analytics/water_analystics_screen.dart';
import 'package:fitness/screens/goal/goal_update_screen.dart';
import 'package:fitness/screens/home/home_screen.dart';
import 'package:fitness/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await dotenv.load(fileName: ".env");
    print("dotenv loaded successfully");
    
    final token = dotenv.env['token'];
    print("API token exists: ${token != null && token.isNotEmpty}");
    if (token != null && token.isNotEmpty) {
      print("Token length: ${token.length}");
      print("First few characters: ${token.substring(0, token.length > 5 ? 5 : token.length)}...");
    } else {
      print("WARNING: API token is missing or empty in .env file!");
      print("Please make sure your .env file contains: token=YOUR_OPENAI_API_KEY");
    }
  } catch (e) {
    print("Failed to load .env file: $e");
    print("Working directory may be incorrect or .env file may not exist.");
    print("Make sure you have a .env file in the root of your project with token=YOUR_OPENAI_API_KEY");
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: CurvedBottomNavBar(),
      debugShowCheckedModeBanner: false,
      darkTheme: null,
    );
  }
}