

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  @override
  String toString() => 'Category($name)';
}

class Item {
  final String id;
  final String name;
  final Category category;
  final double price;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
  });

  @override
  String toString() => 'Item($name, ${category.name}, \$${price.toStringAsFixed(2)})';
}

class CartItem {
  final Item item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});

  double get total => item.price * quantity;

  @override
  String toString() => '${item.name} x $quantity = \$${total.toStringAsFixed(2)}';
}

class Cart {
  final Map<String, CartItem> _items = {}; 

  void addItem(Item item, {int quantity = 1}) {
    if (_items.containsKey(item.id)) {
      _items[item.id]!.quantity += quantity;
    } else {
      _items[item.id] = CartItem(item: item, quantity: quantity);
    }
  }

  void removeItem(String itemId, {int quantity = 1}) {
    if (!_items.containsKey(itemId)) return;
    final ci = _items[itemId]!;
    if (ci.quantity <= quantity) {
      _items.remove(itemId);
    } else {
      ci.quantity -= quantity;
    }
  }

  void removeAllOfItem(String itemId) => _items.remove(itemId);

  void clear() => _items.clear();

  List<CartItem> get items => _items.values.toList();

  double get totalPrice => _items.values.fold(0.0, (s, c) => s + c.total);

  int get totalQuantity => _items.values.fold(0, (s, c) => s + c.quantity);

  // Group items by category
  Map<Category, List<CartItem>> itemsByCategory() {
    final map = <Category, List<CartItem>>{};
    for (final ci in _items.values) {
      map.putIfAbsent(ci.item.category, () => []).add(ci);
    }
    return map;
  }

  @override
  String toString() {
    if (_items.isEmpty) return 'Cart is empty';
    final buffer = StringBuffer();
    for (final ci in _items.values) buffer.writeln(ci);
    buffer.writeln('Total items: $totalQuantity');
    buffer.writeln('Total price: \$${totalPrice.toStringAsFixed(2)}');
    return buffer.toString();
  }
}
