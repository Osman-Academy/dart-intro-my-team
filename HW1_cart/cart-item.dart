import 'item.dart';

class CartItem {
  final Item item;
  int quantity;
  
  CartItem({
    required this.item,
    this.quantity = 1,
  });
  
  double get totalPrice => item.price * quantity;
  
  @override
  String toString() => 'CartItem(${item.name} x$quantity = \$${totalPrice.toStringAsFixed(2)}';
}