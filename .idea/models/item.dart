class Item {
  final String name;
  final double price;
  final String categoryName;

  Item({
    required this.name,
    required this.price,
    required this.categoryName,
  });

  @override
  String toString() {
    return '$name (\$$price) - $categoryName';
  }
}
