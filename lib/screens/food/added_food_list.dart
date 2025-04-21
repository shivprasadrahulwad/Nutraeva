import 'package:fitness/screens/food/food_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoodItemsScreen extends StatefulWidget {
  const FoodItemsScreen({super.key});

  @override
  State<FoodItemsScreen> createState() => _FoodItemsScreenState();
}

class _FoodItemsScreenState extends State<FoodItemsScreen> {
  // Current date for the header
  DateTime currentDate = DateTime.now();

  String getFormattedDate() {
    return DateFormat('EEEE, MMM d').format(currentDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            _buildHeader(),
            // Food items list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  FoodItemCard(
                    title: 'Cheese N Onion saus...',
                    calories: 382,
                    carbs: 36,
                    protein: 36,
                    fat: 36,
                    imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c',
                  ),
                  SizedBox(height: 16),
                  FoodItemCard(
                    title: 'Roast chicken with lem...',
                    calories: 382,
                    carbs: 36,
                    protein: 36,
                    fat: 36,
                    imageUrl: 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6',
                  ),
                  SizedBox(height: 16),
                  FoodItemCard(
                    title: 'Dhal poached eggs wi...',
                    calories: 382,
                    carbs: 36,
                    protein: 36,
                    fat: 36,
                    imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.grey[50],
      child: Column(
        children: [
          // Top navigation bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back button
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              // Title
              const Text(
                'My Diet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Calendar button
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.black87),
                  onPressed: () async {
                    final DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: currentDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        currentDate = selectedDate;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Date and subtitle
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getFormattedDate(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fast And Convenient Way To Eat Right',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final String title;
  final int calories;
  final int carbs;
  final int protein;
  final int fat;
  final String imageUrl;

  const FoodItemCard({
    super.key,
    required this.title,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => RecipeScreen()),
);

      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 15,),
              Text('Breakfast',style: TextStyle(fontSize: 12,color: Colors.grey,fontStyle: FontStyle.italic),)
                ],
              ),
              const SizedBox(width: 12),
              // Food Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Calories
                    Row(
                      children: [
                        const Icon(
                          Icons.bolt,
                          color: Colors.amber,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${calories}kcal',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '8/10',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Nutrition Info
                    Row(
                      children: [
                        _buildNutritionItem('Carbs', carbs, Colors.blue),
                        const SizedBox(width: 16),
                        _buildNutritionItem('Protein', protein, Colors.orange),
                        const SizedBox(width: 16),
                        _buildNutritionItem('Fat', fat, Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String label, int value, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$value g',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          // Progress bar
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              widthFactor: 0.5, // 50% filled
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}