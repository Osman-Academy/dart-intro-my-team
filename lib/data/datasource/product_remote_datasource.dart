import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:string_search_app/data/models/product_model.dart';

@lazySingleton
class ProductRemoteDataSource {
  final Dio dio = Dio();

  Future<List<ProductModel>> fetchProducts() async {
    final response =
        await dio.get('https://fakestoreapi.com/products');

    return (response.data as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}