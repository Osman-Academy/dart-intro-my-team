import 'cart_item.dart';
import 'item.dart';

class Cart {
  List<CartItem> items = [];

  void addItem(Item item) {
    final existing = items.firstWhere(
      (cartItem) => cartItem.item.name == item.name,
      orElse: () => CartItem(item, quantity: 0),
    );

    if (existing.quantity > 0) {
      existing.quantity++;
    } else {
      items.add(CartItem(item));
    }
  }

  void removeItem(Item item) {
    items.removeWhere((cartItem) => cartItem.item.name == item.name);
  }

  void decreaseItem(Item item) {
    final existing = items.firstWhere(
      (cartItem) => cartItem.item.name == item.name,
      orElse: () => CartItem(item, quantity: 0),
    );

    if (existing.quantity > 1) {
      existing.quantity--;
    } else {
      removeItem(item);
    }
  }

  double get total => items.fold(0, (sum, cartItem) => sum + cartItem.totalPrice);

  void printCart() {
    if (items.isEmpty) {
      print("🛒 Your cart is empty.");
      return;
    }

    print("🛒 Cart Contents:");
    for (var cartItem in items) {
      print(
        "${cartItem.item.name} (${cartItem.item.category}) x${cartItem.quantity} = \$${cartItem.totalPrice.toStringAsFixed(2)}"
      );
    }
    print("Total: \$${total.toStringAsFixed(2)}");
    print("----------------------------------");
  }
}
