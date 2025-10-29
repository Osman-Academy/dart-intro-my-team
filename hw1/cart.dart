import 'item.dart';
import 'cartItem.dart';

class Cart {
  final List<CartItem> _items = [];

  void addItem(Item item, {int quantity = 1}) {
    CartItem? existingItem;

    for (var c in _items) {
      if (c.item.id == item.id) {
        existingItem = c;
        break;
      }
    }

    if (existingItem != null) {
      existingItem.quantity += quantity;
    } else {
      _items.add(CartItem(item, quantity));
    }
  }

  void removeItem(String itemId) {
    CartItem? toRemove;
    for (var c in _items) {
      if (c.item.id == itemId) {
        toRemove = c;
        break;
      }
    }
    if (toRemove != null) {
      _items.remove(toRemove);
    }
  }

  double get totalPrice {
    double sum = 0;
    for (var c in _items) {
      sum += c.total;
    }
    return sum;
  }

  void printCart() {
    for (var c in _items) {
      print('${c.item.name} x${c.quantity} = ${c.total}');
    }
    print('Total: $totalPrice');
  }
}
