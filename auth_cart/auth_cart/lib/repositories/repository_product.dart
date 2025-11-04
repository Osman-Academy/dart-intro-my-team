import 'package:navigation/models/product.dart';
import 'package:navigation/models/product_dto.dart';

abstract class RepositoryProduct {
  Future<List<Product>> list(ProductDto productDto);
  Future<Product> view(ProductDto productDto);
}
