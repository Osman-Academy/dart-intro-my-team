import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource, this._client);

  final ProductRemoteDataSource _remoteDataSource;
  final Dio _client;

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
        id: id,
        title: title,
        description: description,
        price: price,
        discountPercentage: discountPercentage,
        rating: rating,
        stock: stock,
        brand: brand,
        category: category,
        thumbnail: thumbnail,
        images: images,
      );
}
