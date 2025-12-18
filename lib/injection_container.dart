import 'package:get_it/get_it.dart';
import 'package:product_catalog_app/features/product_catalog/domain/repositories/product_repository.dart';
import 'core/network/dio_client.dart';
import 'features/product_catalog/data/datasources/product_remote_data_source.dart';
import 'features/product_catalog/data/repositories/product_repository_impl.dart';
import 'features/product_catalog/domain/usecases/get_products.dart';
import 'features/product_catalog/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ProductRepository>(
  () => ProductRepositoryImpl(sl()),
);

  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerFactory(() => ProductBloc(sl()));
}
