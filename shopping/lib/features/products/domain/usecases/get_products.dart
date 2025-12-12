import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  GetProducts(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, List<Product>>> call() {
    return _repository.getProducts();
  }
}
