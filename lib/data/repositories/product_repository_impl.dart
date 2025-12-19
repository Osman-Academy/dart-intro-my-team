import 'package:injectable/injectable.dart';
import 'package:string_search_app/data/datasource/product_remote_datasource.dart';
import 'package:string_search_app/data/models/product_model.dart';
import 'package:string_search_app/domain/entities/product.dart';
import 'package:string_search_app/domain/repositories/product_repository.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<List<Product>> getProducts() async {
    final models = await dataSource.fetchProducts();
    return models.map((model) => model.toEntity()).toList();
  }
}