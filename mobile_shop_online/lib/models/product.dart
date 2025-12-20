import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String status;
  final String? imageUrl;
  final int categoryId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.status,
    this.imageUrl,
    required this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? 'No description',
      price: (json['price'] as num).toDouble(),
      status: json['status'] ?? 'N/A',
      imageUrl: json['imageUrl'],
      categoryId: json['categoryId'],
    );
  }
}
