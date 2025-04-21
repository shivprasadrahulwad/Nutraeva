import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback onTap;

  const MealCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFF5B6BF9),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.add,
                color: Color(0xFF5B6BF9),
                size: 20,
              ),
            ),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
