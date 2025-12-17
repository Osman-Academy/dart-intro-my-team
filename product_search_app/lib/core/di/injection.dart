import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/api_client.dart';
import '../network/dio_factory.dart';
import '../../features/products/data/datasources/product_remote_data_source.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/repositories/product_repository.dart';
import '../../features/products/domain/usecases/get_products.dart';
import '../../features/products/presentation/bloc/products_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // Core
  sl.registerLazySingleton<Dio>(DioFactory.create);
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl()));

  // Data
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remote: sl()),
  );

  // Domain
  sl.registerLazySingleton(() => GetProducts(sl()));

  // Presentation
  sl.registerFactory(() => ProductsBloc(getProducts: sl()));
}
