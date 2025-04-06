import 'package:fitness/screens/intro_screens/wait_gain_screen.dart';
import 'package:flutter/material.dart';

class DesiredWeightScreen extends StatefulWidget {
  const DesiredWeightScreen({Key? key}) : super(key: key);

  @override
  State<DesiredWeightScreen> createState() => _DesiredWeightScreenState();
}

class _DesiredWeightScreenState extends State<DesiredWeightScreen> {
  double selectedWeight = 129;
  final double minWeight = 80;
  final double maxWeight = 220;
  String weightGoal = "Gain Weight";
  bool selectedOption = false;

    void _navigateToNextScreen() {
    if (selectedOption != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WeightGainScreen()),
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Choose your desired weight?',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(flex: 2),
            
            // Weight goal label
            Center(
              child: Text(
                weightGoal,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Weight indicator
            Center(
              child: Text(
                '${selectedWeight.toInt()} lbs',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Custom arrow indicator
            Center(
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
                size: 40,
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Custom slider with tick marks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Colors.white,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 18.0),
                      trackHeight: 30.0,
                      activeTrackColor: Colors.grey[300],
                      inactiveTrackColor: Colors.grey[300],
                      inactiveTickMarkColor: Colors.grey[600],
                      activeTickMarkColor: Colors.grey[600],
                      tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 1.5),
                      valueIndicatorColor: Colors.transparent,
                      valueIndicatorTextStyle: const TextStyle(color: Colors.transparent),
                    ),
                    child: Slider(
                      value: selectedWeight,
                      min: minWeight,
                      max: maxWeight,
                      divisions: 140,
                      onChanged: (value) {
                        setState(() {
                          selectedWeight = value;
                          // Adjust weight goal based on slider position
                          if (value < 110) {
                            weightGoal = "Lose Weight";
                          } else if (value > 150) {
                            weightGoal = "Gain Weight";
                          } else {
                            weightGoal = "Maintain Weight";
                          }
                        });
                      },
                    ),
                  ),
                  
                  // Custom tick marks
                  SizedBox(
                    height: 30,
                    child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width - 48, 30),
                      painter: TickMarksPainter(),
                    ),
                  ),
                  
                  // "lbs" label
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'lbs',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(flex: 3),
            
            // Next button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: GestureDetector(
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
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for the tick marks below the slider
class TickMarksPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;
    
    final double width = size.width;
    const double spacing = 15.0; // Spacing between tick marks
    
    // Draw tick marks
    for (int i = 0; i < width / spacing; i++) {
      final x = i * spacing;
      
      // Vary height for different tick marks
      double height;
      if (i % 5 == 0) {
        height = 20.0;  // Taller tick mark every 5 marks
        paint.color = Colors.grey.shade700;
      } else {
        height = 10.0;  // Regular tick mark
        paint.color = Colors.grey.shade400;
      }
      
      canvas.drawRect(
        Rect.fromLTWH(x, 0, 1.0, height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}