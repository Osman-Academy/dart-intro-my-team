class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String thumbnail;

  Product ({required this.id, required this.title, required this.price, this.description = "", this.thumbnail = ""});
}