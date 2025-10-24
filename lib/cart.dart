import 'models.dart';

class Cart {
  // Map of item -> quantity
  final Map<Item, int> _items = {};

  void addItem(Item item, [int qty = 1]) {
    if (qty <= 0) throw ArgumentError('qty must be > 0');
    _items[item] = (_items[item] ?? 0) + qty;
  }

  /// Remove the item from the cart entirely
  void removeItem(Item item) {
    _items.remove(item);
  }

  /// Get quantity for an item
  int quantityOf(Item item) => _items[item] ?? 0;

  List<Item> get distinctItems => List.unmodifiable(_items.keys);

  int get totalQuantity => _items.values.fold(0, (a, b) => a + b);

  double get totalPrice {
    var sum = 0.0;
    _items.forEach((item, qty) => sum += item.price * qty);
    return sum;
  }

  /// Group items by category name -> list of item names (keeps it lightweight)
  Map<String, List<String>> itemsByCategory() {
    final map = <String, List<String>>{};
    _items.forEach((item, qty) {
      map.putIfAbsent(item.category.name, () => []).add('${item.name} x $qty');
    });
    return map;
  }

  void clear() => _items.clear();

  String summary() {
    if (_items.isEmpty) return 'Cart is empty';
    final lines = <String>[];
    _items.forEach((item, qty) {
      lines.add('${item.name} x $qty = \$${(item.price * qty).toStringAsFixed(2)}');
    });
    lines.add('Total items: $totalQuantity');
    lines.add('Total price: \$${totalPrice.toStringAsFixed(2)}');
    return lines.join('\n');
  }
}
