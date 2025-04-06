// import 'package:fitness/screens/intro_screens/past_used_app_screen.dart';
// import 'package:flutter/material.dart';


// class WorkoutSelectionScreen extends StatefulWidget {
//   @override
//   _WorkoutSelectionScreenState createState() => _WorkoutSelectionScreenState();
// }

// class _WorkoutSelectionScreenState extends State<WorkoutSelectionScreen> {
//   int? selectedOption;

//   void _navigateToNextScreen() {
//     if (selectedOption != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => PastUsedAppScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Container(
//                 height: 4,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             ),
//             SizedBox(height: 24),
//             Text(
//               "How many workouts do you do per week?",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "This will be used to calibrate your custom plan.",
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//             SizedBox(height: 24),
//             _buildWorkoutOption(0, "0 - 2", "Workouts now and then", Icons.circle),
//             _buildWorkoutOption(1, "3 - 5", "A few workouts per week", Icons.more_horiz),
//             _buildWorkoutOption(2, "6+", "Dedicated athlete", Icons.apps),
//             Spacer(),
//             GestureDetector(
//               onTap: selectedOption != null ? _navigateToNextScreen : null,
//               child: Container(
//                 height: 50,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: selectedOption != null ? Colors.black : Colors.grey[300],
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Next",
//                   style: TextStyle(
//                     color: selectedOption != null ? Colors.white : Colors.black38,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWorkoutOption(int value, String title, String subtitle, IconData icon) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedOption = value;
//         });
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8),
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: selectedOption == value ? Colors.black.withOpacity(0.05) : Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: selectedOption == value ? Colors.black : Colors.grey[300]!),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.black, width: 2),
//                 color: selectedOption == value ? Colors.black : Colors.white,
//               ),
//               child: Icon(icon, color: selectedOption == value ? Colors.white : Colors.black),
//             ),
//             SizedBox(width: 16),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
//                 Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.black54)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:fitness/screens/intro_screens/past_used_app_screen.dart';
import 'package:flutter/material.dart';

class WorkoutSelectionScreen extends StatefulWidget {
  @override
  _WorkoutSelectionScreenState createState() => _WorkoutSelectionScreenState();
}

class _WorkoutSelectionScreenState extends State<WorkoutSelectionScreen> {
  int? selectedOption;

  void _navigateToNextScreen() {
    if (selectedOption != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PastUsedAppScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Text(
              "How many workouts do you do per week?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              "This will be used to calibrate your custom plan.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 24),
            _buildWorkoutOption(0, "0 - 2", "Workouts now and then", Icons.circle),
            _buildWorkoutOption(1, "3 - 5", "A few workouts per week", Icons.more_horiz),
            _buildWorkoutOption(2, "6+", "Dedicated athlete", Icons.apps),
            Spacer(),
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
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutOption(int value, String title, String subtitle, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = value;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selectedOption == value ? Colors.black.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selectedOption == value ? Colors.black : Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
                color: selectedOption == value ? Colors.black : Colors.white,
              ),
              child: Icon(icon, color: selectedOption == value ? Colors.white : Colors.black),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
