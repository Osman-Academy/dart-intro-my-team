import '../models/product_model.dart';
import '../../../../core/network/dio_client.dart';


abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient client;

  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get('https://fakestoreapi.com/products');
    final list = response.data as List;
    return list.map((e) => ProductModel.fromJson(e)).toList();
  }
}
