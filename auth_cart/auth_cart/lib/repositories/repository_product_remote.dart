import 'package:dio/dio.dart';
import 'package:navigation/models/product.dart';
import 'package:navigation/models/product_dto.dart';
import 'package:navigation/repositories/repository_product.dart';

class RepositoryProductRemote implements RepositoryProduct {
  Dio dio = Dio();
  @override
  Future<List<Product>> list(ProductDto productDto) async {
    var value = await dio.get("https://dummyjson.com/products");
    List<Product> products = [];
    var data = value.data;
    try {
      for (var item in data["products"]) {
        products.add(Product.formJson(item));
      }
    } catch (e) {
      print(e);
    }

    return products;
  }

  @override
  Future<Product> view(ProductDto productDto) async {
    var value =
        await dio.get("https://dummyjson.com/products/${productDto.productId}");
    return Product.formJson(value.data);
  }
}
