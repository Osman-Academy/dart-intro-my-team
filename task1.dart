// task1.dart

class Category {
  final int id;
  final String name;
  Category(this.id, this.name);
  @override
  String toString() => name;
}

class Item {
  final int id;
  final String name;
  final double price;
  final Category category;
  Item(this.id, this.name, this.price, this.category);
  @override
  String toString() => '$name (\$${price.toStringAsFixed(2)}) - Category: ${category.name}';
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

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);

  void showCart() {
    if (_items.isEmpty) {
      print('🛒 Your cart is empty.');
    } else {
      print('\n🛍️ Items in your cart:');
      for (var item in _items) {
        print(' - ${item.name} (\$${item.price})');
      }
      print('Total: \$${totalPrice.toStringAsFixed(2)}');
    }
  }
}

void main() {
  var electronics = Category(1, 'Electronics');
  var clothing = Category(2, 'Clothing');

  var phone = Item(1, 'Smartphone', 699.99, electronics);
  var laptop = Item(2, 'Laptop', 1099.99, electronics);
  var tshirt = Item(3, 'T-Shirt', 19.99, clothing);

  var cart = Cart();

  cart.addItem(phone);
  cart.addItem(tshirt);
  cart.addItem(laptop);

  cart.showCart();

  cart.removeItem(tshirt);
  cart.showCart();
}
