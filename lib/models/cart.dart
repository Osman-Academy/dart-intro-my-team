import 'cart_item.dart';

class Cart {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => Map.unmodifiable(_items);

  int get totalItems => _items.values.fold(0, (s, i) => s + i.quantity);

  double get totalPrice => _items.values.fold(0.0, (s, i) => s + i.total);

  void addItem(CartItem item) {
    if (_items.containsKey(item.id)) {
      _items[item.id]!.quantity += item.quantity;
    } else {
      _items[item.id] = item;
    }
  }

  void removeItem(String id) {
    _items.remove(id);
  }

  void updateQuantity(String id, int quantity) {
    if (_items.containsKey(id)) {
      if (quantity <= 0) _items.remove(id);
      else _items[id] = _items[id]!.copyWith(quantity: quantity);
    }
  }

  void clear() => _items.clear();
}
