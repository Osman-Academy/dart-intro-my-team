class Category {
  final String id;
  final String name;

  Category(this.id, this.name);
}

class Item {
  final String id;
  final String name;
  final String categoryId;
  final double price;

  Item(this.id, this.name, this.categoryId, this.price);
}

class CartItem {
  final Item item;
  int quantity;

  CartItem(this.item, this.quantity);

  double get total {
    return item.price * quantity;
  }
}

class Cart {
  final List<CartItem> _items = [];

  void addItem(Item item, {int quantity = 1}) {
    CartItem? existingItem;

    for (var c in _items) {
      if (c.item.id == item.id) {
        existingItem = c;
        break;
      }
    }

    if (existingItem != null) {
      existingItem.quantity += quantity;
    } else {
      _items.add(CartItem(item, quantity));
    }
  }

  void removeItem(String itemId) {
    CartItem? toRemove;
    for (var c in _items) {
      if (c.item.id == itemId) {
        toRemove = c;
        break;
      }
    }
    if (toRemove != null) {
      _items.remove(toRemove);
    }
  }

  double get totalPrice {
    double sum = 0;
    for (var c in _items) {
      sum += c.total;
    }
    return sum;
  }

  void printCart() {
    for (var c in _items) {
      print('${c.item.name} x${c.quantity} = ${c.total}');
    }
    print('Total: $totalPrice');
  }
}

void main() {
  final electronics = Category('1', 'Electronics');
  final food = Category('2', 'Food');

  final phone = Item('p1', 'Phone', electronics.id, 600);
  final apple = Item('f1', 'Apple', food.id, 2);

  final cart = Cart();
  cart.addItem(phone);
  cart.addItem(apple, quantity: 5);

  cart.printCart();
}
