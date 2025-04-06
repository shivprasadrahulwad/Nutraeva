import 'package:fitness/screens/intro_screens/desired_weight_screen.dart';
import 'package:flutter/material.dart';

class GoalSelectionScreen extends StatefulWidget {
  @override
  _GoalSelectionScreenState createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  String selectedGoal = "Gain Weight";
  bool selectedOption = false;

  void selectGoal(String goal) {
    setState(() {
      selectedGoal = goal;
    });
  }


    void _navigateToNextScreen() {
    if (selectedOption != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DesiredWeightScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes default back arrow
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(width: 16),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "What is your goal?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "This helps us generate a plan for your calorie intake.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            GoalOption(
              title: "Gain Weight",
              isSelected: selectedGoal == "Gain Weight",
              onTap: () => selectGoal("Gain Weight"),
            ),
            const SizedBox(height: 10),
            GoalOption(
              title: "Maintain",
              isSelected: selectedGoal == "Maintain",
              onTap: () => selectGoal("Maintain"),
            ),
            const SizedBox(height: 10),
            GoalOption(
              title: "Lose Weight",
              isSelected: selectedGoal == "Lose Weight",
              onTap: () => selectGoal("Lose Weight"),
            ),
            const Spacer(),
            GestureDetector(
              onTap: selectedOption != null ? _navigateToNextScreen : null,
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: selectedOption != null ? Colors.black : Colors.grey[300],
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: selectedOption != null ? Colors.white : Colors.black38,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class GoalOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}