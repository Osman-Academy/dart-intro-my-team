class Product {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? rating;
  double? discountPercentage;
  String? thumbnail;
  int stock;

  Product({
    this.id,
    this.title,
    this.category,
    this.description,
    this.price,
    this.rating,
    this.discountPercentage,
    this.thumbnail,
    this.stock = 0,
  });

  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
      id: data["id"],
      title: data["title"],
      description: data["description"],
      category: data["category"],
      price: data["price"]?.toDouble(),
      rating: data["rating"]?.toDouble(),
      discountPercentage: data["discountPercentage"]?.toDouble(),
      thumbnail: data["thumbnail"],
      stock: data["stock"] ?? 0,
    );
  }
}