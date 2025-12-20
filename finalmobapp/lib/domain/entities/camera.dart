import 'package:equatable/equatable.dart';

class Camera extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;

  const Camera({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, name, brand, description, price, imageUrl, rating];
}
