class Item {
  final String name;
  final double price;

  Item({
    required this.name,
    required this.price,
  });

  @override
  String toString() => "$name — \$${price.toStringAsFixed(2)}";
}
