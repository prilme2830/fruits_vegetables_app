import 'package:flutter/material.dart';

import '../main.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final shop = ShopScope.of(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'My Profile',
            style: TextStyle(
              fontSize: 25,
              color: kInk,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF237A3B), Color(0xFF58A85B)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 48, color: kGreen),
                ),
                SizedBox(height: 12),
                Text(
                  'Fresh Basket Shopper',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Fresh choices every day',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Cart items',
                  value: '${shop.cartCount}',
                  icon: Icons.shopping_bag_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Orders',
                  value: '${shop.orders.length}',
                  icon: Icons.receipt_long_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'About the app',
            style: TextStyle(
              fontSize: 19,
              color: kInk,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Card(
            child: ListTile(
              leading: Icon(Icons.eco_outlined, color: kGreen),
              title: Text('Fresh produce'),
              subtitle: Text('Shop fruits and vegetables.'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.cloud_outlined, color: kGreen),
              title: Text('API integration'),
              subtitle: Text('Fruit data from the Fruityvice API.'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.school_outlined, color: kGreen),
              title: Text('CC 302 Final Project'),
              subtitle: Text(
                'Flutter widgets, navigation, API, and state management.',
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Center(
            child: Text(
              'Fresh Basket • Version 1.0.0',
              style: TextStyle(color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Icon(icon, color: kGreen, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                color: kInk,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
