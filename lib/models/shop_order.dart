import 'package:flutter/material.dart';

import 'cart_item.dart';

enum PaymentMethod { cashOnDelivery, gcash, card }

extension PaymentMethodX on PaymentMethod {
  String get label => switch (this) {
    PaymentMethod.cashOnDelivery => 'Cash on Delivery',
    PaymentMethod.gcash => 'GCash',
    PaymentMethod.card => 'Credit / Debit Card',
  };

  IconData get icon => switch (this) {
    PaymentMethod.cashOnDelivery => Icons.payments_outlined,
    PaymentMethod.gcash => Icons.phone_android_rounded,
    PaymentMethod.card => Icons.credit_card_rounded,
  };
}

class ShopOrder {
  ShopOrder({
    required this.id,
    required this.createdAt,
    required this.items,
    required this.total,
    required this.paymentMethod,
  });

  final String id;
  final DateTime createdAt;
  final List<CartItem> items;
  final double total;
  final PaymentMethod paymentMethod;
}