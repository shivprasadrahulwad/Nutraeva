import 'package:fitness/screens/intro_screens/wait_compare_screen.dart';
import 'package:flutter/material.dart';

class WeightGainSpeedScreen extends StatefulWidget {
  const WeightGainSpeedScreen({Key? key}) : super(key: key);

  @override
  State<WeightGainSpeedScreen> createState() => _WeightGainSpeedScreenState();
}

class _WeightGainSpeedScreenState extends State<WeightGainSpeedScreen> {
  double _selectedGainRate = 0.2;
  bool selectedOption = false;
  
  // The predefined values on the slider
  final List<double> _predefinedValues = [0.2, 1.5, 3.0];
  
  // Labels for the slider positions
  final Map<double, String> _speedLabels = {
    0.2: 'Slow and Steady',
    1.5: 'Moderate Pace',
    3.0: 'Rapid Progress'
  };

    void _navigateToNextScreen() {
    if (selectedOption != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WeightLossScreen()),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How fast do you want\nto reach your goal?',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              
              // Gain weight text
              const SizedBox(height: 70),
              const Text(
                'Gain Weight speed per week',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              // Weight value display
              const SizedBox(height: 20),
              Center(
                child: Text(
                  '${_selectedGainRate.toStringAsFixed(1)} lbs',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              // Speed icons row
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAnimalIcon(Icons.accessibility_new, Colors.orange.shade300),
                  _buildAnimalIcon(Icons.pets, Colors.black),
                  _buildAnimalIcon(Icons.speed, Colors.black),
                ],
              ),
              
              // Custom slider
              SizedBox(
                height: 50,
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 2,
                    activeTrackColor: Colors.black,
                    inactiveTrackColor: Colors.grey.shade300,
                    thumbColor: Colors.black,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                    showValueIndicator: ShowValueIndicator.never,
                  ),
                  child: Slider(
                    min: 0.2,
                    max: 3.0,
                    value: _selectedGainRate,
                    divisions: 28, // (3.0 - 0.2) * 10 for smooth 0.1 increments
                    onChanged: (newValue) {
                      // Find the closest predefined value if within threshold
                      double threshold = 0.15;
                      double closestValue = _predefinedValues.firstWhere(
                        (value) => (value - newValue).abs() < threshold,
                        orElse: () => newValue,
                      );
                      
                      // If close to a predefined value, snap to it
                      if ((closestValue - newValue).abs() < threshold) {
                        newValue = closestValue;
                      }
                      
                      setState(() {
                        _selectedGainRate = double.parse(newValue.toStringAsFixed(1));
                      });
                    },
                  ),
                ),
              ),
              
              // Weight values
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '0.2 lbs',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '1.5 lbs',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '3.0 lbs',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              
              // Slow and steady label
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    _getCurrentSpeedLabel(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Next button
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
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
      ),
    );
  }

  String _getCurrentSpeedLabel() {
    // Find the closest predefined value
    double? closestValue;
    double minDiff = double.infinity;
    
    for (double value in _predefinedValues) {
      double diff = (value - _selectedGainRate).abs();
      if (diff < minDiff) {
        minDiff = diff;
        closestValue = value;
      }
    }
    
    // Return the label for the closest value
    return _speedLabels[closestValue] ?? 'Slow and Steady';
  }

  Widget _buildAnimalIcon(IconData icon, Color color) {
    return Container(
      width: 60,
      height: 60,
      child: Icon(
        icon,
        size: 36,
        color: color,
      ),
    );
  }
}