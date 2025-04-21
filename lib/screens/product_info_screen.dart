import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/screens/models/product.dart';
import 'package:fitness/widgets/macrobar_painter.dart';
import 'package:flutter/material.dart';

class ProductInfoWidget extends StatelessWidget {
  final Product product;

  const ProductInfoWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with drag indicator
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Product image and basic info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: product.imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: product.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.no_food),
                          ),
                        )
                      : Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.no_food, size: 50),
                        ),
                ),
              ),
              const SizedBox(width: 16),

              // Product details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.brand,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.qr_code, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            product.barcode,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Serving size: ${product.nutritionFacts.servingSize}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Nutrition facts header
          const Text(
            'Nutrition Facts',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),

          // Quick nutrition summary
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNutritionSummaryItem(
                  'Calories',
                  '${product.nutritionFacts.calories.toStringAsFixed(0)} kcal',
                  Colors.orange,
                ),
                _buildNutritionSummaryItem(
                  'Proteins',
                  '${product.nutritionFacts.proteins.toStringAsFixed(1)}g',
                  Colors.green,
                ),
                _buildNutritionSummaryItem(
                  'Carbs',
                  '${product.nutritionFacts.carbohydrates.toStringAsFixed(1)}g',
                  Colors.blue,
                ),
                _buildNutritionSummaryItem(
                  'Fat',
                  '${product.nutritionFacts.fat.toStringAsFixed(1)}g',
                  Colors.red,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Detailed nutrition facts
          _buildNutritionFactRow('Proteins',
              '${product.nutritionFacts.proteins.toStringAsFixed(1)}g'),
          _buildNutritionFactRow('Carbohydrates',
              '${product.nutritionFacts.carbohydrates.toStringAsFixed(1)}g'),
          _buildNutritionFactRow('  - Sugars',
              '${product.nutritionFacts.sugar.toStringAsFixed(1)}g'),
          _buildNutritionFactRow('  - Fiber',
              '${product.nutritionFacts.fiber.toStringAsFixed(1)}g'),
          _buildNutritionFactRow(
              'Fat', '${product.nutritionFacts.fat.toStringAsFixed(1)}g'),
          _buildNutritionFactRow(
              'Salt', '${product.nutritionFacts.salt.toStringAsFixed(2)}g'),
          const SizedBox(height: 20),

          // Nutritional chart
          const Text(
            'Macro Ratio',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: CustomPaint(
              size: const Size(double.infinity, 100),
              painter: MacroBarPainter(
                proteins: product.nutritionFacts.proteins,
                carbs: product.nutritionFacts.carbohydrates,
                fats: product.nutritionFacts.fat,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Proteins', Colors.green),
              const SizedBox(width: 20),
              _buildLegendItem('Carbs', Colors.blue),
              const SizedBox(width: 20),
              _buildLegendItem('Fats', Colors.red),
            ],
          ),
          const SizedBox(height: 24),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add to Diary'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    // TODO: Add to food diary
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Added to food diary'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.favorite_border),
                label: const Text('Save'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  // TODO: Save to favorites
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Saved to favorites'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getNutritionIcon(label),
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  IconData _getNutritionIcon(String nutrient) {
    switch (nutrient) {
      case 'Calories':
        return Icons.local_fire_department;
      case 'Proteins':
        return Icons.fitness_center;
      case 'Carbs':
        return Icons.grain;
      case 'Fat':
        return Icons.opacity;
      default:
        return Icons.info;
    }
  }

  Widget _buildNutritionFactRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

