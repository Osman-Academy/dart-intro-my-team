class Category {
  String id;
  String name;
  Category({required this.id, required this.name});
  @override
  String toString() => 'Category($name)';
}

class Item {
  String id;
  String name;
  double price;
  Category category;
  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  @override
  String toString() => 'Item($name, \$${price.toStringAsFixed(2)})';
}

class CartItem {
  Item item;
  int quantity;

  CartItem({required this.item, this.quantity = 1}) {
    if (quantity < 1) quantity = 1;
  }

  double get subtotal => item.price * quantity;

  @override
  String toString() =>
      '${item.name} x $quantity = \$${subtotal.toStringAsFixed(2)}';
}

class Cart {
  Map<String, CartItem> _items = {};
  double _couponFixed = 0.0;
  double _couponPercent = 0.0;

  void addItem(Item item, {int qty = 1}) {
    var key = item.id;
    if (_items.containsKey(key)) {
      _items[key]!.quantity += qty;
      if (_items[key]!.quantity < 1) _items[key]!.quantity = 1;
    } else {
      _items[key] = CartItem(item: item, quantity: qty < 1 ? 1 : qty);
    }
  }

  void removeItem(String itemId) => _items.remove(itemId);

  void updateQuantity(String itemId, int qty) {
    if (qty <= 0) {
      removeItem(itemId);
    } else if (_items.containsKey(itemId)) {
      _items[itemId]!.quantity = qty;
    }
  }

  void clear() {
    _items.clear();
    _couponFixed = 0.0;
    _couponPercent = 0.0;
  }

  void applyFixedDiscount(double amount) {
    _couponFixed = amount < 0 ? 0.0 : amount;
  }

  void applyPercentDiscount(double percent) {
    _couponPercent = (percent < 0) ? 0.0 : percent;
  }

  double get subtotal =>
      _items.values.fold(0.0, (sum, ci) => sum + ci.subtotal);

  double get discount {
    var byPercent = subtotal * _couponPercent;
    var totalDiscount = byPercent + _couponFixed;
    return totalDiscount > subtotal ? subtotal : totalDiscount;
  }

  double get total => (subtotal - discount);

  Map<String, List<CartItem>> itemsGroupedByCategory() {
    Map<String, List<CartItem>> map = {};
    for (var ci in _items.values) {
      var catId = ci.item.category.id;
      map.putIfAbsent(catId, () => []).add(ci);
    }
    return map;
  }

  List<CartItem> get allItems => _items.values.toList();

  @override
  String toString() {
    var buffer = StringBuffer();
    buffer.writeln('Cart:');
    if (_items.isEmpty) {
      buffer.writeln('  (empty)');
    } else {
      for (var ci in _items.values) {
        buffer.writeln('  ${ci.toString()}');
      }
      buffer.writeln('Subtotal: \$${subtotal.toStringAsFixed(2)}');
      buffer.writeln('Discount: \$${discount.toStringAsFixed(2)}');
      buffer.writeln('Total: \$${total.toStringAsFixed(2)}');
    }
    return buffer.toString();
  }
}

void main() {
  var catFood = Category(id: 'c1', name: 'Food');
  var catDrinks = Category(id: 'c2', name: 'Drinks');

  var apple = Item(id: 'i1', name: 'Apple', price: 0.99, category: catFood);
  var bread = Item(id: 'i2', name: 'Bread', price: 2.5, category: catFood);
  var cola = Item(id: 'i3', name: 'Cola', price: 1.5, category: catDrinks);

  var cart = Cart();
  cart.addItem(apple, qty: 5);
  cart.addItem(bread);
  cart.addItem(cola, qty: 3);
  print(cart);

  var grouped = cart.itemsGroupedByCategory();
  print('Grouped by category:');
  for (var entry in grouped.entries) {
    print('  Category ${entry.key}:');
    for (var ci in entry.value) {
      print('    ${ci}');
    }
  }

  cart.applyPercentDiscount(0.1);
  cart.applyFixedDiscount(1.0);
  print('After discounts:');
  print('Subtotal: \$${cart.subtotal.toStringAsFixed(2)}');
  print('Discount: \$${cart.discount.toStringAsFixed(2)}');
  print('Total: \$${cart.total.toStringAsFixed(2)}');
}