class Item {
  String name;
  double price;

  Item(this.name, this.price);
}

class Category {
  String name;
  List<Item> items;

  Category(this.name, this.items);
}

class Cart {
  List<Item> _cartItems = [];

  void addItem(Item item) {
    _cartItems.add(item);
    print("${item.name} added to cart.");
  }

  void removeItem(Item item) {
    _cartItems.remove(item);
    print("${item.name} removed from cart.");
  }

  double getTotal() {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }

  void showCart() {
    print("🛒 Cart contains:");
    for (var item in _cartItems) {
      print("- ${item.name} (${item.price} \$)");
    }
    print("Total: ${getTotal()} \$");
  }
}

void main() {
  var fruits = Category("Fruits", [
    Item("Apple", 1.5),
    Item("Banana", 1.0),
  ]);

  var drinks = Category("Drinks", [
    Item("Juice", 2.5),
    Item("Water", 0.8),
  ]);

  var cart = Cart();
  cart.addItem(fruits.items[0]);
  cart.addItem(drinks.items[1]);
  cart.showCart();
}
