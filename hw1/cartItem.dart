import 'item.dart';

class CartItem {
  final Item item;
  int quantity;

  CartItem(this.item, this.quantity);

  double get total {
    return item.price * quantity;
  }
}