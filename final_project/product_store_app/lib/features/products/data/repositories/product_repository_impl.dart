import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final productModels = await remoteDataSource.getProducts();
      final products = productModels.map((model) => model.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(Failure.serverFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    try {
      final productModel = await remoteDataSource.getProductById(id);
      return Right(productModel.toEntity());
    } catch (e) {
      return Left(Failure.serverFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(Failure.serverFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      String category) async {
    try {
      final productModels =
          await remoteDataSource.getProductsByCategory(category);
      final products = productModels.map((model) => model.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(Failure.serverFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String pattern) async {
    try {
      final result = await getProducts();
      return result.fold(
        (failure) => Left(failure),
        (products) {
          final filtered = products
              .where((product) =>
                  product.title.toLowerCase().contains(pattern.toLowerCase()) ||
                  product.description
                      .toLowerCase()
                      .contains(pattern.toLowerCase()))
              .toList();
          return Right(filtered);
        },
      );
    } catch (e) {
      return Left(Failure.serverFailure(e.toString()));
    }
  }
}
