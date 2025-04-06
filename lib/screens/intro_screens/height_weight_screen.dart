import 'package:fitness/screens/intro_screens/birthdate_select_screen.dart';
import 'package:flutter/material.dart';

class HeightWeightScreen extends StatefulWidget {
  const HeightWeightScreen({Key? key}) : super(key: key);

  @override
  State<HeightWeightScreen> createState() => _HeightWeightScreenState();
}

class _HeightWeightScreenState extends State<HeightWeightScreen> {
  bool isImperial = true;
  bool selectedOption = false;
  
  // Imperial units
  int selectedFeet = 5;
  int selectedInches = 5;
  int selectedPounds = 119;
  
  // Metric units
  int selectedCm = 165;
  int selectedKg = 54;

  final List<int> feetOptions = List.generate(8, (index) => index + 1); // 1-8 feet
  final List<int> inchesOptions = List.generate(12, (index) => index); // 0-11 inches
  final List<int> poundsOptions = List.generate(300, (index) => index + 50); // 50-349 pounds
  final List<int> cmOptions = List.generate(181, (index) => index + 100); // 100-280 cm
  final List<int> kgOptions = List.generate(201, (index) => index + 30); // 30-230 kg

    void _navigateToNextScreen() {
    if (selectedOption != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BirthdateScreen()),
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
            // Title and description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Height & Weight',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This will be used to calibrate your custom plan.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 60),
            
            // Units toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 24),
                  Text(
                    'Imperial',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isImperial ? Colors.black : Colors.grey[400],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Switch(
                    value: !isImperial,
                    onChanged: (value) {
                      setState(() {
                        isImperial = !value;
                      });
                    },
                    activeTrackColor: Colors.grey[300],
                    inactiveTrackColor: Colors.grey[300],
                    activeColor: Colors.white,
                    inactiveThumbColor: Colors.white,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Metric',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: !isImperial ? Colors.black : Colors.grey[400],
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Height and Weight headers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Height',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Weight',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Height and Weight selectors
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    // Height selector
                    isImperial
                        ? Expanded(
                            child: Row(
                              children: [
                                // Feet selector
                                Expanded(
                                  child: _buildScrollableList(
                                    feetOptions,
                                    selectedFeet,
                                    'ft',
                                    (value) => setState(() => selectedFeet = value),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Inches selector
                                Expanded(
                                  child: _buildScrollableList(
                                    inchesOptions,
                                    selectedInches,
                                    'in',
                                    (value) => setState(() => selectedInches = value),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: _buildScrollableList(
                              cmOptions,
                              selectedCm,
                              'cm',
                              (value) => setState(() => selectedCm = value),
                            ),
                          ),
                    // Weight selector
                    Expanded(
                      child: _buildScrollableList(
                        isImperial ? poundsOptions : kgOptions,
                        isImperial ? selectedPounds : selectedKg,
                        isImperial ? 'lb' : 'kg',
                        (value) => setState(() {
                          if (isImperial) {
                            selectedPounds = value;
                          } else {
                            selectedKg = value;
                          }
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
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

  Widget _buildScrollableList(
    List<int> options,
    int selectedValue,
    String unit,
    Function(int) onSelected,
  ) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListWheelScrollView(
        onSelectedItemChanged: (index) {
          onSelected(options[index]);
        },
        itemExtent: 60,
        diameterRatio: 1.5,
        physics: const FixedExtentScrollPhysics(),
        useMagnifier: true,
        magnification: 1.2,
        controller: FixedExtentScrollController(
          initialItem: options.indexOf(selectedValue),
        ),
        children: options.map((value) {
          final isSelected = value == selectedValue;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Text(
              '$value $unit',
              style: TextStyle( 
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.black : Colors.grey[400],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}