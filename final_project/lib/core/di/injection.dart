final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()));

  sl.registerLazySingleton(() => GetProducts(sl()));

  sl.registerFactory(() => ProductBloc(sl()));
}
