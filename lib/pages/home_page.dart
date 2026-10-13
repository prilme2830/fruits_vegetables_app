import 'package:flutter/material.dart';

import '../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final shop = ShopScope.of(context);
    final featured = shop.products.take(4).toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Row(
            children: [
              Icon(Icons.eco, size: 34, color: kGreen),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FRESH BASKET',
                    style: TextStyle(
                      color: kGreen,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 24,
                      color: kInk,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF237A3B), Color(0xFF58A85B)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    'Eat fresh.\nFeel good.',
                    style: TextStyle(
                      fontSize: 29,
                      height: 1.2,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.shopping_basket_rounded,
                  size: 75,
                  color: Colors.white,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const Card(
            child: ListTile(
              leading: Icon(Icons.local_shipping_outlined, color: kGreen),
              title: Text('Freshness delivered'),
              subtitle: Text('Choose your favourite fresh produce.'),
            ),
          ),
        ],
      ),
    );
  }
}
