class Product {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? rating;
  double? discountPercentage;
  String? thumbnail;

  Product(
      {this.id,
      this.title,
      this.category,
      this.description,
      this.price,
      this.rating,
      this.discountPercentage,
      this.thumbnail});

  factory Product.formJson(Map<String, dynamic> data) {
    return Product(
        id: data["id"],
        title: data["title"],
        description: data["description"],
        category: data["category"],
        price: data["price"],
        rating: data["rating"],
        discountPercentage: data["discountPercentage"],
        thumbnail: data["thumbnail"]);
  }
}
