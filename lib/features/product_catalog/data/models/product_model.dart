import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required int id,
    required String title,
    required double price,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json)
      => _$ProductModelFromJson(json);
}

extension ProductMapper on ProductModel {
  Product toEntity() {
    return Product(id: id, title: title, price: price);
  }
}

