import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Recipe image with back button and Add button
          Stack(
            children: [
              // Recipe image
              Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Back button
              Positioned(
                top: 40,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                    onPressed: () {},
                  ),
                ),
              ),
              
              // Add button
              Positioned(
                top: 40,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: const Text(
                      'Add',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              
              // Fall decor overlay (subtle leaf icons)
              Positioned(
                top: 10,
                right: 60,
                child: Opacity(
                  opacity: 0.5,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1511880400959-1ecdfa2c1316?ixlib=rb-1.2.1&auto=format&fit=crop&w=100&q=80',
                    width: 40,
                  ),
                ),
              ),
            ],
          ),
          
          // Recipe details card
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe title and bookmark button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'Roast Chicken With Lemon Grass',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: Colors.blue,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            isSaved = !isSaved;
                          });
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Nutrition information
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNutritionItem(Icons.local_fire_department, 'Calories', '2880 kcal', Colors.orange),
                      _buildNutritionItem(Icons.circle, 'Carbs', '67 gms', Colors.grey),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNutritionItem(Icons.egg, 'Protein', '80 gms', Colors.brown),
                      _buildNutritionItem(Icons.water_drop, 'Fat', '20 gms', Colors.yellow),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Health score
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Health Score',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      _buildHealthScoreIndicator(),
                      const SizedBox(width: 8),
                      const Text(
                        '7/10',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(IconData icon, String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.edit,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthScoreIndicator() {
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              value: 0.7, // 7/10
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
              strokeWidth: 4,
            ),
          ),
          const Center(
            child: Text(
              '7',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}