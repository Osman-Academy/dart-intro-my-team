class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final String description;
  final String brand;
  final double rating;
  final int stock;
  final String thumbnail;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.brand,
    required this.rating,
    required this.stock,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['title'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: (json['images'] != null && (json['images'] as List).isNotEmpty)
          ? (json['images'] as List).first as String
          : (json['thumbnail'] ?? ''),
      description: json['description'] ?? '',
      brand: json['brand'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}
