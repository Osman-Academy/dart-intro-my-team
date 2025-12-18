import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'core/network_interceptor.dart';
import 'data/datasources/product_remote_data_source.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/product_repository.dart';
import 'presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(() => ProductBloc(repository: sl()));
  sl.registerLazySingleton(() {
  final dio = Dio();
  dio.interceptors.add(ErrorInterceptor());
  return dio;
});
}