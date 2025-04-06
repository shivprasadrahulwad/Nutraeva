import 'package:flutter/material.dart';

class DietSelectionScreen extends StatefulWidget {
  const DietSelectionScreen({Key? key}) : super(key: key);

  @override
  State<DietSelectionScreen> createState() => _DietSelectionScreenState();
}

class _DietSelectionScreenState extends State<DietSelectionScreen> {
  String? selectedDiet;

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
            const Expanded(
              child: SizedBox(
                height: 4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
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
            // Heading
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Do you follow a specific diet?",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Diet options
            buildDietOption('Classic'),
            const SizedBox(height: 16),
            buildDietOption('Pescatarian'),
            const SizedBox(height: 16),
            buildDietOption('Vegetarian'),
            const SizedBox(height: 16),
            buildDietOption('Vegan'),

            const Spacer(),

            // Next button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: selectedDiet != null
                    ? () {
                        // Proceed to next step
                        print("Selected diet: $selectedDiet");
                      }
                    : null,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: selectedDiet != null ? Colors.black : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget buildDietOption(String title) {
    bool isSelected = selectedDiet == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDiet = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? Border.all(color: Colors.black, width: 3) : null,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: buildIconForDiet(title),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconForDiet(String diet) {
    switch (diet) {
      case 'Classic':
        return const Icon(Icons.restaurant, size: 20, color: Colors.black);
      case 'Pescatarian':
        return const Icon(Icons.set_meal, size: 20, color: Colors.black);
      case 'Vegetarian':
        return const Icon(Icons.apple, size: 20, color: Colors.black);
      case 'Vegan':
        return const Icon(Icons.eco, size: 20, color: Colors.black);
      default:
        return const Icon(Icons.restaurant, size: 20, color: Colors.black);
    }
  }
}
