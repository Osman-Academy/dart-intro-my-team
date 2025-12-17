import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  const GetProducts(this._repo);
  final ProductRepository _repo;

  Future<List<Product>> call() => _repo.getProducts();
}
