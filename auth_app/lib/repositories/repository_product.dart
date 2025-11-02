import 'package:auth_app/models/product.dart';
import 'package:auth_app/models/product_dto.dart';

abstract class RepositoryProduct {
  Future<List<Product>> list(ProductDto productDto);
  Future<Product> view(ProductDto productDto);
}