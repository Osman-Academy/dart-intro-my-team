import 'package:dio/dio.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await dio.get(
        'https://dummyjson.com/products/search',
        queryParameters: {'q': query},
      );

      final List data = response.data['products'];
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception("The requested products were not found (404).");
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection timed out.");
      } else {
        throw Exception("Something went wrong.");
      }
    } catch (e) {
      throw Exception("An unexpected error occurred.");
    }
  }
}