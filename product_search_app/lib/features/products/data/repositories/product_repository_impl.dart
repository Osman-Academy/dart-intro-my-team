import '../../products.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_dto.dart';


class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required this.remote});

  final ProductRemoteDataSource remote;

  @override
  Future<List<Product>> getProducts() async {
    final dtos = await remote.fetchProducts();
    return dtos.map((e) => e.toEntity()).toList();
  }
}
