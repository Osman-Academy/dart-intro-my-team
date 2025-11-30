import '../models/product.dart';
import 'api_service.dart';

class ProductService {
  final ApiService _api = ApiService();

  Future<List<Product>> getProducts({String? search, String? category}) {
    return _api.fetchProducts(search: search, category: category);
  }

  Future<List<String>> getCategories() {
    return _api.fetchCategories();
  }
}
