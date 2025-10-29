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
    print('${item.name} added to cart.');
  }

  void removeItem(Item item) {
    _items.remove(item);
    print('${item.name} removed from cart.');
  }

  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + item.price);
  }

  void showCart() {
    print('🛒 Cart items:');
    for (var item in _items) {
      print('- ${item.name} : \$${item.price}');
    }
    print('Total: \$${totalPrice}');
  }
}

void main() {
 
  var fruits = Category("Fruits", [
    Item("Apple", 1.2),
    Item("Banana", 0.8),
  ]);

  var drinks = Category("Drinks", [
    Item("Water", 0.5),
    Item("Juice", 2.0),
  ]);

  
  var cart = Cart();

  cart.addItem(fruits.items[0]);
  cart.addItem(drinks.items[1]);
  cart.showCart();
}
