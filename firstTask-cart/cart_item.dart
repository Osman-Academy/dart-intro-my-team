import 'item.dart';

class CartItem {
  Item item;
  int quantity;

  CartItem(this.item, {this.quantity = 1});

  double get totalPrice => item.getFinalPrice() * quantity;
}
