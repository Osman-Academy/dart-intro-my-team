import 'item.dart';

class Category {
  final String name;
  final List<Item> items;

  Category({
    required this.name,
    required this.items,
  });

  @override
  String toString() => "$name (${items.length} items)";
}
