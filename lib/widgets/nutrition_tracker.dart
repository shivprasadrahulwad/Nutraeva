import 'package:fitness/widgets/nutrition_progress_bar.dart';
import 'package:flutter/material.dart';

class NutritionTracker extends StatelessWidget {
  final int carbs;
  final int protein;
  final int fat;
  
  const NutritionTracker({
    Key? key,
    required this.carbs,
    required this.protein,
    required this.fat,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: NutrientProgressBar(
              label: 'Carbs',
              current: carbs,
              target: 339,
              color: Colors.green,
            ),
          ),
          Expanded(
            child: NutrientProgressBar(
              label: 'Protein',
              current: protein,
              target: 143,
              color: Colors.orange,
            ),
          ),
          Expanded(
            child: NutrientProgressBar(
              label: 'Fat',
              current: fat,
              target: 339,
              color: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}