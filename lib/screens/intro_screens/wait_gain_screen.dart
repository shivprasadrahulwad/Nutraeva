import 'package:fitness/screens/intro_screens/goal_stopping_screen.dart';
import 'package:fitness/screens/intro_screens/wait_gain_speed_screen.dart';
import 'package:flutter/material.dart';

class WeightGainScreen extends StatefulWidget {
  const WeightGainScreen({Key? key}) : super(key: key);

  @override
  _WeightGainScreenState createState() => _WeightGainScreenState();
}

class _WeightGainScreenState extends State<WeightGainScreen> {
  bool selectedOption = true; // Assuming true for now — adjust logic as needed

  void _navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WeightGainSpeedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
           

            const Spacer(flex: 2),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(text: "Gaining "),
                        TextSpan(
                          text: "10.0 lbs",
                          style: TextStyle(color: Color(0xFFD4A373)),
                        ),
                        TextSpan(text: " is a realistic target. it's not hard at all!"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "90% of users say that the change is obvious after using Cal AI and it is not\neasy to rebound.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 3),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: selectedOption ? _navigateToNextScreen : null,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: selectedOption ? Colors.black : Colors.grey[300],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: selectedOption ? Colors.white : Colors.black38,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
