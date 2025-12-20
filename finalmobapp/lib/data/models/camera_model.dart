import '../../domain/entities/camera.dart';

class CameraModel extends Camera {
  const CameraModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.description,
    required super.price,
    required super.imageUrl,
    required super.rating,
  });

  factory CameraModel.fromJson(Map<String, dynamic> json) {
    return CameraModel(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
    };
  }
}
