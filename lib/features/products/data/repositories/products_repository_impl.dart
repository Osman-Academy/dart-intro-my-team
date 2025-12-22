import '../../domain/repositories/products_repository.dart';
import '../datasources/products_local_datasource.dart';
import '../datasources/products_remote_datasource.dart';
import '../models/product_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsLocalDataSource localDataSource;
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<ProductModel>> getProducts() async {
    try {

      return await remoteDataSource.getProducts();
    } catch (_) {

      return localDataSource.getProducts();
    }
  }
}
