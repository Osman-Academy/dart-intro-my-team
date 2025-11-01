class Category {
  final String name;

  const Category(this.name);

  double getDiscountRate() {
    switch (name.toLowerCase()) {
      case 'food':
        return 0.05;
      case 'clothing':
        return 0.10;
      case 'electronics':
        return 0.15;
      default:
        return 0.0;
    }
  }

  @override
  String toString() => name;
}
