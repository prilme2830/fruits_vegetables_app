import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://www.fruityvice.com/api/fruit/all'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((item) => Product.fromFruitApi(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load fruits');
    }
  }
}
