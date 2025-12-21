import 'package:final_products_app/core/resources/data_state.dart';
import 'package:final_products_app/features/domain/models/product.dart';

abstract class ProductRepository {
  Future<DataState<List<Product>>> getProducts();
}