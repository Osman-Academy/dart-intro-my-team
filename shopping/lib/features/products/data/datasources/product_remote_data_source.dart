import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  /// Fetch all products from dummyjson.
  Future<Either<String, List<ProductModel>>> getProducts();

  /// Fetch a single product by id from dummyjson.
  Future<Either<String, ProductModel>> getProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl(this._client);

  final Dio _client;

  @override
  Future<Either<String, List<ProductModel>>> getProducts() async {
    try {
      final response = await _client.get('https://dummyjson.com/products');
      final data = response.data as Map<String, dynamic>;
      final productsJson = (data['products'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();
      final products =
          productsJson.map(ProductModel.fromJson).toList(growable: false);
      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ProductModel>> getProduct(int id) async {
    try {
      final response =
          await _client.get('https://dummyjson.com/products/$id');
      final product =
          ProductModel.fromJson(response.data as Map<String, dynamic>);
      return Right(product);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
