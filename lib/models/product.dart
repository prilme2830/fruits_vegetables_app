enum ProductCategory { fruit, vegetable }

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    this.description = '',
  });

  final String id;
  final String name;
  final ProductCategory category;
  final double price;
  final String imageUrl;
  final String description;

  String get categoryLabel =>
      category == ProductCategory.fruit ? 'Fruit' : 'Vegetable';

  static Product fromFruitApi(Map<String, dynamic> json) {
    final name = (json['name'] ?? 'Fruit').toString();
    final key = name.toLowerCase();

    const prices = {
      'apple': 2.50,
      'banana': 1.80,
      'orange': 2.20,
      'mango': 3.50,
      'pineapple': 4.50,
      'watermelon': 5.00,
      'strawberry': 4.00,
      'grape': 4.20,
      'kiwi': 3.80,
    };

    const images = {
      'apple': 'assets/images/apple.webp',
      'banana': 'assets/images/banana.jpg',
      'orange': 'assets/images/orange.jpg',
      'mango': 'assets/images/manga.webp',
      'pineapple': 'assets/images/pineapple.webp',
      'watermelon': 'assets/images/watermelon.webp',
      'grape': 'https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=700',
      'kiwi': 'https://images.unsplash.com/photo-1585059895524-72359e06133a?w=700',
    };

    final imageId = images[key] ??
        'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=700';

    return Product(
      id: key.replaceAll(RegExp(r'[^a-z0-9]'), '-'),
      name: name,
      category: ProductCategory.fruit,
      price: prices[key] ?? 3.00,
      imageUrl: imageId,
      description: 'Fresh $name',
    );
  }

  static const List<Product> samples = [
    Product(
      id: 'apple',
      name: 'Apple',
      category: ProductCategory.fruit,
      price: 2.50,
      imageUrl: 'assets/images/apple.webp',
      description: 'Crisp and sweet',
    ),
    Product(
      id: 'banana',
      name: 'Banana',
      category: ProductCategory.fruit,
      price: 1.80,
      imageUrl: 'assets/images/banana.jpg',
      description: 'Naturally sweet',
    ),
    Product(
      id: 'orange',
      name: 'Orange',
      category: ProductCategory.fruit,
      price: 2.20,
      imageUrl: 'assets/images/orange.jpg',
      description: 'Juicy citrus fruit',
    ),
    Product(
      id: 'mango',
      name: 'Mango',
      category: ProductCategory.fruit,
      price: 3.50,
      imageUrl: 'assets/images/manga.webp',
      description: 'Tropical and juicy',
    ),
    Product(
      id: 'pineapple',
      name: 'Pineapple',
      category: ProductCategory.fruit,
      price: 4.50,
      imageUrl: 'assets/images/pineapple.webp',
      description: 'Sweet tropical fruit',
    ),
    Product(
      id: 'watermelon',
      name: 'Watermelon',
      category: ProductCategory.fruit,
      price: 5.00,
      imageUrl: 'assets/images/watermelon.webp',
      description: 'Refreshing and hydrating',
    ),
    Product(
      id: 'carrot',
      name: 'Carrot',
      category: ProductCategory.vegetable,
      price: 1.60,
      imageUrl: 'assets/images/carrot.jpg',
      description: 'Crunchy root vegetable',
    ),
    Product(
      id: 'broccoli',
      name: 'Broccoli',
      category: ProductCategory.vegetable,
      price: 2.80,
      imageUrl: 'assets/images/broccoli.png',
      description: 'Fresh green florets',
    ),
    Product(
      id: 'tomato',
      name: 'Tomato',
      category: ProductCategory.vegetable,
      price: 2.00,
      imageUrl: 'assets/images/tomato.jpg',
      description: 'Bright and flavorful',
    ),
    Product(
      id: 'cucumber',
      name: 'Cucumber',
      category: ProductCategory.vegetable,
      price: 1.50,
      imageUrl: 'assets/images/cucumber.jpg',
      description: 'Cool and crisp',
    ),
    Product(
      id: 'bell-pepper',
      name: 'Bell Pepper',
      category: ProductCategory.vegetable,
      price: 2.40,
      imageUrl: 'assets/images/bellpepper.jpg',
      description: 'Colorful and crunchy',
    ),
    Product(
      id: 'spinach',
      name: 'Spinach',
      category: ProductCategory.vegetable,
      price: 2.10,
      imageUrl: 'assets/images/spinach.jpg',
      description: 'Tender leafy greens',
    ),
  ];
}
