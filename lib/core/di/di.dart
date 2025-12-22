import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/products/data/datasources/products_local_datasource.dart';
import '../../features/products/data/datasources/products_remote_datasource.dart';
import '../../features/products/data/repositories/products_repository_impl.dart';
import '../../features/products/domain/repositories/products_repository.dart';
import '../../features/products/presentation/bloc/products_bloc.dart';
import 'package:ct_makeup_catalog/features/products/presentation/cubit/cart_cubit.dart';

final sl = GetIt.instance;

Future<void> initDi() async {

  sl.registerLazySingleton<Dio>(
        () => Dio(
      BaseOptions(
        baseUrl: 'http://localhost:3000',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  sl.registerLazySingleton<ProductsLocalDataSource>(
        () => ProductsLocalDataSource(),
  );

  sl.registerLazySingleton<ProductsRemoteDataSource>(
        () => ProductsRemoteDataSource(sl()),
  );

  sl.registerLazySingleton<ProductsRepository>(
        () => ProductsRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );


  sl.registerFactory(() => ProductsBloc(sl()));
  sl.registerLazySingleton(() => CartCubit());
}
