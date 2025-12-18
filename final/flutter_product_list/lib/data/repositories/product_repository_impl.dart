import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> searchProducts(String query) async {
    try {
      final productModels = await remoteDataSource.searchProducts(query);
      return productModels.map((model) => ProductModel.toEntity(model)).toList();
    } catch (e) {
      throw Exception("Repository Error: $e");
    }
  }
}