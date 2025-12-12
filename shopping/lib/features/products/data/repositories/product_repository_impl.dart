import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    final result = await _remoteDataSource.getProducts();
    return result.fold(
      (error) => Left(Failure(error)),
      (models) => Right(models.map((m) => m.toEntity()).toList(growable: false)),
    );
  }

  @override
  Future<Either<Failure, Product>> getProduct(int id) async {
    final result = await _remoteDataSource.getProduct(id);
    return result.fold(
      (error) => Left(Failure(error)),
      (model) => Right(model.toEntity()),
    );
  }
}

extension on ProductModel {
  Product toEntity() => Product(
        id: this.id,
        title: this.title,
        description: this.description,
        price: this.price,
        discountPercentage: this.discountPercentage,
        rating: this.rating,
        stock: this.stock,
        brand: this.brand,
        category: this.category,
        thumbnail: this.thumbnail,
        images: this.images,
      );
}
