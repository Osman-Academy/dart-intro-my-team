import 'package:navigation/models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  
  CartItem(this.product, this.quantity);
  
  double get totalPrice => (product.price ?? 0) * quantity;
}