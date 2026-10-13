import 'package:flutter/material.dart';

import '../main.dart';
import '../models/shop_order.dart';
import '../widgets/empty_state.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final shop = ShopScope.of(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              'My Orders',
              style: TextStyle(
                fontSize: 25,
                color: kInk,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: shop.orders.isEmpty
                ? const EmptyState(
                    icon: Icons.receipt_long_outlined,
                    title: 'No orders yet',
                    message: 'Your placed orders will appear here.',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    itemCount: shop.orders.length,
                    itemBuilder: (context, index) {
                      final order = shop.orders[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: kLightGreen,
                            child: Icon(Icons.check_circle, color: kGreen),
                          ),
                          title: Text(
                            'Order #${order.id.substring(order.id.length - 6)}',
                          ),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${order.items.length} product type(s)\n'
                                '${order.createdAt.year}-'
                                '${order.createdAt.month.toString().padLeft(2, '0')}-'
                                '${order.createdAt.day.toString().padLeft(2, '0')}',
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    order.paymentMethod.icon,
                                    size: 14,
                                    color: kGreen,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    order.paymentMethod.label,
                                    style: const TextStyle(
                                      color: kGreen,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '\$${order.total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: kGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (dialogContext) => AlertDialog(
                                      title: const Text('Delete order?'),
                                      content: const Text(
                                        'Remove this order from history?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                            dialogContext,
                                            false,
                                          ),
                                          child: const Text('Cancel'),
                                        ),
                                        FilledButton(
                                          onPressed: () => Navigator.pop(
                                            dialogContext,
                                            true,
                                          ),
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirmed == true) {
                                    shop.deleteOrder(order.id);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}