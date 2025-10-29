import 'category.dart';

class Item {
  final int id;
  final String name;
  final double price;
  final Category category;
  
  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });
  
  @override
  String toString() => 'Item(id: $id, name: $name, price: \$$price)';
}