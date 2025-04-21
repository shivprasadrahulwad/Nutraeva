import 'package:fitness/screens/food/added_food_list.dart';
import 'package:fitness/screens/image_camera/camera_screen.dart';
import 'package:fitness/widgets/meal_card.dart';
import 'package:flutter/material.dart';

class MealSection extends StatelessWidget {
  final VoidCallback onAddMeal;

  const MealSection({
    Key? key,
    required this.onAddMeal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Planned Meal's",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoodItemsScreen()),
                );
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF5B6BF9),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        MealCard(
          title: 'Add Breakfast',
          subtitle: 'Recommended | 540-715 Kcal',
          imageUrl:
              'https://media.post.rvohealth.io/wp-content/uploads/2024/06/toast-avocado-eggs-732x549-thumbnail.jpg',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraScreen()),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        MealCard(
          title: 'Add Lunch',
          subtitle: 'Recommended | 540-715 Kcal',
          imageUrl:
              'https://rakskitchen.net/wp-content/uploads/2015/10/Lunch-menu-57.jpg',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraScreen()),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        MealCard(
          title: 'Add Dinner',
          subtitle: 'Recommended | 540-715 Kcal',
          imageUrl:
              'https://www.archanaskitchen.com/images/archanaskitchen/0-Affiliate-Articles/Recipe_Collection/everyday_meal_plate_with_tharvani_charu_urali_roast_and_more-2.jpg',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraScreen()),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        MealCard(
          title: 'Add Snacks',
          subtitle: 'Recommended | 540-715 Kcal',
          imageUrl:
              'https://assets.zeezest.com/blogs/PROD_Banner_1665399532357_thumb_1200.jpeg?w=1200&q=75&fm=webp',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraScreen()),
            );
          },
        ),
      ],
    );
  }
}
