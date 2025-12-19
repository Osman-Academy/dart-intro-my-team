import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/product_remote_data_source.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/get_products_usecase.dart';
import 'presentation/bloc/product_bloc.dart';

final sl = GetIt.instance; 

void init() {
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetProductsUseCase(sl()));

  sl.registerFactory(() => ProductBloc(getProductsUseCase: sl()));
}