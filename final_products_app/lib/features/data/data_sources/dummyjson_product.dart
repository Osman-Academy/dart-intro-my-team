import 'package:dio/dio.dart';
import 'package:final_products_app/features/data/dto/product_dto.dart';

class DummyProductRemoteDataSource {
  final Dio dio;

  DummyProductRemoteDataSource(this.dio);

  Future<List<ProductDto>> getProducts() async {
    try {
      final response = await dio.get('https://dummyjson.com/products');

      final productsJson = response.data['products'];

      return productsJson.map((product) {
        final dto = ProductDto.fromJson(product);

        print('product runtimeType: ${product.runtimeType}');
        print('dto runtimeType: ${dto.runtimeType}');
        print('dto: $dto');

        return dto;
      }).cast<ProductDto>().toList();
    } on DioException catch (e) {
      throw e;
    }
  }
}