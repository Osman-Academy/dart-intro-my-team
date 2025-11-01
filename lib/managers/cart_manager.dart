import 'package:flutter/foundation.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';

class CartManager extends ChangeNotifier {
  final Cart _cart = Cart();

  Cart get cart => _cart;

  void addItem(CartItem item) {
    _cart.addItem(item);
    notifyListeners();
  }

  void removeItem(String id) {
    _cart.removeItem(id);
    notifyListeners();
  }

  void updateQuantity(String id, int qty) {
    _cart.updateQuantity(id, qty);
    notifyListeners();
  }

  int get totalItems => _cart.totalItems;
  double get totalPrice => _cart.totalPrice;

  void clear() {
    _cart.clear();
    notifyListeners();
  }
}
