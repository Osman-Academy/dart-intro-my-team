import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:string_search_app/domain/entities/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required int id,
    required String title,
    required String description,
    required double price,
    required String category,
    required String image,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

extension ProductMapper on ProductModel {
  Product toEntity() => Product(
        id: id,
        title: title,
        description: description,
        price: price,
        category: category,
        image: image,
      );
}