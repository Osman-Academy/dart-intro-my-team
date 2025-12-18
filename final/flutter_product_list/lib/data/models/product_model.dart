import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required int id,
    required String title,
    required String description,
    required String category,
    required double price,
    required double rating,
    required int stock,
    required String brand,
    required String thumbnail,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  static Product toEntity(ProductModel model) => Product(
        id: model.id,
        title: model.title,
        description: model.description,
        category: model.category,
        price: model.price,
        rating: model.rating,
        stock: model.stock,
        brand: model.brand,
        thumbnail: model.thumbnail,
      );
}