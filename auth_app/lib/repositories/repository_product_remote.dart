import 'package:dio/dio.dart';
import 'package:auth_app/models/product.dart';
import 'package:auth_app/models/product_dto.dart';
import 'package:auth_app/repositories/repository_product.dart';

class RepositoryProductRemote implements RepositoryProduct {
  Dio dio = Dio();
  
  @override
  Future<List<Product>> list(ProductDto productDto) async {
    try {
      var response = await dio.get("https://dummyjson.com/products");
      
      if (response.statusCode == 200) {
        List<Product> products = [];
        var data = response.data;
        
        for (var item in data["products"]) {
          products.add(Product.fromJson(item));
        }
        
        return products;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  @override
  Future<Product> view(ProductDto productDto) async {
    try {
      var response = await dio.get("https://dummyjson.com/products/${productDto.productId}");
      
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }
}