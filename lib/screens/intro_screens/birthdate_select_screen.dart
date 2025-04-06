import 'package:fitness/screens/intro_screens/goal_selection_screen.dart';
import 'package:flutter/material.dart';

class BirthdateScreen extends StatefulWidget {
  const BirthdateScreen({Key? key}) : super(key: key);

  @override
  State<BirthdateScreen> createState() => _BirthdateScreenState();
}

class _BirthdateScreenState extends State<BirthdateScreen> {
  // Selected date components
  String selectedMonth = "January";
  int selectedDay = 1;
  int selectedYear = 2012;
  bool selectedOption = false;

  // Options for scrollable lists
  final List<String> months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];
  
  // Days 1-31
  final List<int> days = List.generate(31, (index) => index + 1);
  
  // Years (showing from 1950 to current year)
  final List<int> years = List.generate(
    DateTime.now().year - 1950 + 1, 
    (index) => DateTime.now().year - index
  );

    void _navigateToNextScreen() {
    if (selectedOption != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GoalSelectionScreen()),
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
                children: [
                  const Text(
                    'When were you born?',
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
            
            const Spacer(),
            
            // Date selectors
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  // Month selector
                  Expanded(
                    child: _buildScrollableList(
                      months.map((month) => month).toList(),
                      selectedMonth,
                      (value) => setState(() => selectedMonth = value),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Day selector
                  Expanded(
                    child: _buildScrollableList(
                      days.map((day) => day.toString().padLeft(2, '0')).toList(),
                      selectedDay.toString().padLeft(2, '0'),
                      (value) => setState(() => selectedDay = int.parse(value)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Year selector
                  Expanded(
                    child: _buildScrollableList(
                      years.map((year) => year.toString()).toList(),
                      selectedYear.toString(),
                      (value) => setState(() => selectedYear = int.parse(value)),
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
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
    List<String> options,
    String selectedValue,
    Function(String) onSelected,
  ) {
    final int selectedIndex = options.indexOf(selectedValue);
    
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListWheelScrollView.useDelegate(
        onSelectedItemChanged: (index) {
          onSelected(options[index]);
        },
        itemExtent: 60,
        diameterRatio: 1.5,
        physics: const FixedExtentScrollPhysics(),
        useMagnifier: true,
        magnification: 1.2,
        controller: FixedExtentScrollController(
          initialItem: selectedIndex >= 0 ? selectedIndex : 0,
        ),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: options.length,
          builder: (context, index) {
            final isSelected = options[index] == selectedValue;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                options[index],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.black : Colors.grey[400],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}