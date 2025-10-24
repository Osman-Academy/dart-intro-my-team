
class Category {
  final String id;
  final String name;

  const Category({required this.id, required this.name});

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) => other is Category && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Item {
  final String id;
  final String name;
  final Category category;
  final double price;

  const Item({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
  });

  @override
  String toString() => '$name (\$${price.toStringAsFixed(2)})';

  @override
  bool operator ==(Object other) => other is Item && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
