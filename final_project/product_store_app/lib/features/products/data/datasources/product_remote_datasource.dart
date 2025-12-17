import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(int id);
  Future<List<String>> getCategories();
  Future<List<ProductModel>> getProductsByCategory(String category);
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await apiClient.dio.get('/products');
    return (response.data as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    final response = await apiClient.dio.get('/products/$id');
    return ProductModel.fromJson(response.data);
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await apiClient.dio.get('/products/categories');
    return List<String>.from(response.data);
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final response = await apiClient.dio.get('/products/category/$category');
    return (response.data as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }
}
