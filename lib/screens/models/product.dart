class Product {
  final String barcode;
  final String name;
  final String brand;
  final String imageUrl;
  final NutritionFacts nutritionFacts;

  Product({
    required this.barcode,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.nutritionFacts,
  });

  factory Product.fromOpenFoodFacts(String barcode, Map<String, dynamic> data) {
    final nutriments = data['nutriments'] ?? {};
    
    return Product(
      barcode: barcode,
      name: data['product_name'] ?? 'Unknown Product',
      brand: data['brands'] ?? 'Unknown Brand',
      imageUrl: data['image_url'] ?? '',
      nutritionFacts: NutritionFacts(
        calories: (nutriments['energy-kcal_100g'] ?? 0.0).toDouble(),
        proteins: (nutriments['proteins_100g'] ?? 0.0).toDouble(),
        carbohydrates: (nutriments['carbohydrates_100g'] ?? 0.0).toDouble(),
        fat: (nutriments['fat_100g'] ?? 0.0).toDouble(),
        fiber: (nutriments['fiber_100g'] ?? 0.0).toDouble(),
        sugar: (nutriments['sugars_100g'] ?? 0.0).toDouble(),
        salt: (nutriments['salt_100g'] ?? 0.0).toDouble(),
        servingSize: data['serving_size'] ?? '100g',
      ),
    );
  }
}

class NutritionFacts {
  final double calories;
  final double proteins;
  final double carbohydrates;
  final double fat;
  final double fiber;
  final double sugar;
  final double salt;
  final String servingSize;

  NutritionFacts({
    required this.calories,
    required this.proteins,
    required this.carbohydrates,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.salt,
    required this.servingSize,
  });
}