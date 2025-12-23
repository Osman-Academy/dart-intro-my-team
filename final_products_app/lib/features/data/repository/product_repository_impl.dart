import 'package:dio/dio.dart';
import 'package:final_products_app/core/resources/data_state.dart';
import 'package:final_products_app/features/data/data_sources/dummyjson_product.dart';
import 'package:final_products_app/features/data/dto/product_dto.dart';
import 'package:final_products_app/features/data/mapper/product_mapper.dart';
import 'package:final_products_app/features/domain/models/product.dart';
import 'package:final_products_app/features/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final DummyProductRemoteDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);
  
  @override
  Future<DataState<List<Product>>> getProducts() async {
    try {
      final List<ProductDto> productDtos = await dataSource.getProducts();
      return DataSuccess(productDtos.map((product) => product.toEntity()).toList());
    } on DioException catch (e) {
      return DataFailure(e);
    }
  }
}