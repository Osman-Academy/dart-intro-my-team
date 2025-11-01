import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final String categoryId;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.price,
    this.quantity = 1,
  });

  double get total => price * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      title: title,
      categoryId: categoryId,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}
