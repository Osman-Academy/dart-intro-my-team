import '../entities/product.dart';
import '../repositories/product_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetProductsUseCase extends UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<List<Product>> call(NoParams params) {
    return repository.getProducts();
  }
}

