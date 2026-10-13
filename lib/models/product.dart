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
      'apple': 'photo-1560806887-1e4cd0b6cbd6',
      'banana': 'photo-1571771894821-ce9b6c11b08e',
      'orange': 'photo-1547514701-42782101795e',
      'mango': 'photo-1553279768-865429fa0078',
      'pineapple': 'photo-1550258987-190a2d41a8ba',
      'watermelon': 'photo-1587049352846-4a222e784d38',
      'grape': 'photo-1537640538966-79f369143f8f',
      'kiwi': 'photo-1585059895524-72359e06133a',
    };

    final imageId = images[key] ?? 'photo-1560806887-1e4cd0b6cbd6';

    return Product(
      id: key.replaceAll(RegExp(r'[^a-z0-9]'), '-'),
      name: name,
      category: ProductCategory.fruit,
      price: prices[key] ?? 3.00,
      imageUrl:
          'https://images.unsplash.com/$imageId?w=700&q=85&auto=format&fit=crop',
      description: 'Fresh $name',
    );
  }

  static const List<Product> samples = [
    Product(
      id: 'apple',
      name: 'Apple',
      category: ProductCategory.fruit,
      price: 2.50,
      imageUrl:
          'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=700',
      description: 'Crisp and sweet',
    ),
    Product(
      id: 'banana',
      name: 'Banana',
      category: ProductCategory.fruit,
      price: 1.80,
      imageUrl:
          'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=700',
      description: 'Naturally sweet',
    ),
    Product(
      id: 'orange',
      name: 'Orange',
      category: ProductCategory.fruit,
      price: 2.20,
      imageUrl:
          'https://images.unsplash.com/photo-1547514701-42782101795e?w=700',
      description: 'Juicy citrus fruit',
    ),
    Product(
      id: 'mango',
      name: 'Mango',
      category: ProductCategory.fruit,
      price: 3.50,
      imageUrl:
          'https://images.unsplash.com/photo-1553279768-865429fa0078?w=700',
      description: 'Tropical and juicy',
    ),
    Product(
      id: 'pineapple',
      name: 'Pineapple',
      category: ProductCategory.fruit,
      price: 4.50,
      imageUrl:
          'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=700',
      description: 'Sweet tropical fruit',
    ),
    Product(
      id: 'watermelon',
      name: 'Watermelon',
      category: ProductCategory.fruit,
      price: 5.00,
      imageUrl:
          'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=700',
      description: 'Refreshing and hydrating',
    ),
    Product(
      id: 'carrot',
      name: 'Carrot',
      category: ProductCategory.vegetable,
      price: 1.60,
      imageUrl:
          'https://images.unsplash.com/photo-1445282768818-728615cc910a?w=700',
      description: 'Crunchy root vegetable',
    ),
    Product(
      id: 'broccoli',
      name: 'Broccoli',
      category: ProductCategory.vegetable,
      price: 2.80,
      imageUrl:
          'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=700',
      description: 'Fresh green florets',
    ),
    Product(
      id: 'tomato',
      name: 'Tomato',
      category: ProductCategory.vegetable,
      price: 2.00,
      imageUrl:
          'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=700',
      description: 'Bright and flavorful',
    ),
    Product(
      id: 'cucumber',
      name: 'Cucumber',
      category: ProductCategory.vegetable,
      price: 1.50,
      imageUrl:
          'https://images.unsplash.com/photo-1449300079323-02e209d9d3a6?w=700',
      description: 'Cool and crisp',
    ),
    Product(
      id: 'bell-pepper',
      name: 'Bell Pepper',
      category: ProductCategory.vegetable,
      price: 2.40,
      imageUrl:
          'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=700',
      description: 'Colorful and crunchy',
    ),
    Product(
      id: 'spinach',
      name: 'Spinach',
      category: ProductCategory.vegetable,
      price: 2.10,
      imageUrl:
          'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=700',
      description: 'Tender leafy greens',
    ),
  ];
}
