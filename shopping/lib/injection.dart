import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/products/data/datasources/product_remote_data_source.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/domain/usecases/get_product.dart';
import 'features/products/domain/usecases/get_products.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  sl.registerLazySingleton<Dio>(() => Dio());

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl<Dio>()));

  // Repositories
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl<ProductRemoteDataSource>(), sl<Dio>()));

  // Use cases
  sl.registerFactory(() => GetProducts(sl<ProductRepository>()));
  sl.registerFactory(() => GetProduct(sl<ProductRepository>()));
}
