import 'package:freezed_annotation/freezed_annotation.dart';
import '../../products.dart';

part 'product_dto.freezed.dart';
part 'product_dto.g.dart';

@freezed
class ProductDto with _$ProductDto {
  const factory ProductDto({
    required int id,
    required String title,
    required num price,
    required String description,
    required String category,
    required String image,
  }) = _ProductDto;

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);
}

extension ProductDtoMapper on ProductDto {
  Product toEntity() => Product(
        id: id,
        title: title,
        price: price.toDouble(),
        description: description,
        category: category,
        image: image,
      );
}
