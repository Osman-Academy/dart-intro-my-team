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
  List<Item> cartItems = [];

  void addItem(Item item) {
    cartItems.add(item);
    print("${item.name} added to cart!");
  }

  double getTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item.price;
    }
    return total;
  }

  void showCart() {
    print("Items in cart:");
    for (var item in cartItems) {
      print("- ${item.name}: \$${item.price}");
    }
    print("Total: \$${getTotal()}");
  }
}

void main() {
  var electronics = Category("Electronics", [
    Item("Phone", 700),
    Item("Laptop", 1200),
  ]);

  var cart = Cart();
  cart.addItem(electronics.items[0]);
  cart.addItem(electronics.items[1]);
  cart.showCart();
}
