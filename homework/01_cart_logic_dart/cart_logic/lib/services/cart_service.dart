import '../models/item.dart';

class CartService {
  final List<Item> _items = [];

  void addItem(Item item) {
    _items.add(item);
    print("${item.name} added");
  }

  void removeItem(Item item) {
    _items.remove(item);
    print("${item.name} removed");
  }

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.price);

  void printCart() {
    print("\nCart items:");
    for (final item in _items) {
      print("- ${item.name}: \$${item.price}");
    }
    print("Total: \$${totalPrice}");
  }
}
