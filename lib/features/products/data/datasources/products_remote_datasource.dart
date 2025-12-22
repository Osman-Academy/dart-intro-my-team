import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductsRemoteDataSource {
  final Dio dio;

  ProductsRemoteDataSource(this.dio);

  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get('/products');

    final list = response.data as List;
    return list.map((e) => ProductModel.fromJson(e)).toList();
  }
}
