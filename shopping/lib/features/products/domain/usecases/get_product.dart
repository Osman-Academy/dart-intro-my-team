import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProduct {
  GetProduct(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, Product>> call(int id) {
    return _repository.getProduct(id);
  }
}
