import 'package:final_products_app/features/data/dto/product_dto.dart';
import 'package:final_products_app/features/domain/models/product.dart';

extension ProductMapper on ProductDto {
  Product toEntity() {
    return Product(
      id: id,
      title: title,
      description: description,
      price: price,
      thumbnail: thumbnail, 
    );
  }
}