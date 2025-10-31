class Item {
  final String name;
  final double price;

  Item(this.name, this.price);
}

class Category {
  final String name;
  final List<Item> items;

  Category(this.name, this.items);
}

class Cart {
  final List<Item> _items = [];

  void addItem(Item item) {
    _items.add(item);
  }

  void removeItem(Item item) {
    _items.remove(item);
  }

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.price);

  List<Item> get items => List.unmodifiable(_items);

  void clearCart() {
    _items.clear();
  }

  bool contains(Item item) => _items.contains(item);
}
