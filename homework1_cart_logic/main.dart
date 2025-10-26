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
    print('${item.name} added to cart');
  }

  void removeItem(Item item) {
    _items.remove(item);
    print('${item.name} removed from cart');
  }

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.price);

  void showCart() {
    print('\n🛒 Cart items:');
    for (var item in _items) {
      print('- ${item.name}: \$${item.price}');
    }
    print('Total: \$${totalPrice}\n');
  }
}

void main() {
  final electronics = Category('Electronics', [
    Item('Phone', 800),
    Item('Laptop', 1500),
  ]);

  final clothes = Category('Clothes', [
    Item('T-Shirt', 20),
    Item('Jeans', 50),
  ]);

  final cart = Cart();
  cart.addItem(electronics.items[0]);
  cart.addItem(clothes.items[1]);
  cart.showCart();

  cart.removeItem(electronics.items[0]);
  cart.showCart();
}
