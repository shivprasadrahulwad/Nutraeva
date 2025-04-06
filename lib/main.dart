// import 'package:fitness/screens/image_camera/image_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// Future<void> main() async {
//   await dotenv.load(fileName: ".env");
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Zoneo',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const ImageScreen(),
//     );
//   }
// }



import 'package:fitness/screens/home/home_screen.dart';
import 'package:fitness/screens/image_camera/camera_screen.dart';
import 'package:fitness/screens/intro_screens/desired_weight_screen.dart';
import 'package:fitness/screens/intro_screens/gender_selection_screen.dart';
import 'package:fitness/screens/intro_screens/goal_stopping_screen.dart';
import 'package:fitness/screens/intro_screens/wait_gain_speed_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitness/screens/image_camera/image_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // Ensure Flutter binding is initialized before doing anything else
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Load environment variables with proper error handling
    await dotenv.load(fileName: ".env");
    print("dotenv loaded successfully");
    
    // Debug info about token
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
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      darkTheme: null,
    );
  }
}