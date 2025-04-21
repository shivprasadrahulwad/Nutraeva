import 'package:flutter/material.dart';

class NutrientProgressBar extends StatelessWidget {
  final String label;
  final int current;
  final int target;
  final Color color;

  const NutrientProgressBar({
    Key? key,
    required this.label,
    required this.current,
    required this.target,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Spacer(),
          Icon(Icons.directions_bike, size: 20,)
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '$current',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                ' / ${target}g',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: current / target,
            backgroundColor: color.withOpacity(0.2),
            color: color,
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}
