import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  /// Fetch all items from backend.
  Future<Either<String, List<ProductModel>>> getProducts();

  /// Fetch a single item by id from backend.
  Future<Either<String, ProductModel>> getProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl(this._client);

  final Dio _client;

  @override
  Future<Either<String, List<ProductModel>>> getProducts() async {
    try {
      // NOTE: this project is designed to work with a simple local backend.
      // Example: json-server on http://localhost:3000
      // GET http://localhost:3000/products  -> returns a JSON array
      final response = await _client.get('http://localhost:3000/products');
      final productsJson = (response.data as List<dynamic>)
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
      final response = await _client.get('http://localhost:3000/products/$id');
      final product =
          ProductModel.fromJson(response.data as Map<String, dynamic>);
      return Right(product);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
