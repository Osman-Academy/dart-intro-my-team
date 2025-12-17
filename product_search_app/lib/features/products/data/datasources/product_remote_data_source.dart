import '../../../../core/network/api_client.dart';
import '../models/product_dto.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductDto>> fetchProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<List<ProductDto>> fetchProducts() async {
    final res = await _client.get('/products');
    final data = res.data;
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(ProductDto.fromJson)
          .toList();
    }
    throw Exception('Unexpected response: ${data.runtimeType}');
  }
}
