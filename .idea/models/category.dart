import 'item.dart';

class Category {
  final String name;
  final List<Item> items;

  Category({
    required this.name,
    required this.items,
  });

  void showItems() {
    print('\n📂 Category: $name');
    for (var item in items) {
      print('- ${item.name} — \$${item.price}');
    }
  }
}
