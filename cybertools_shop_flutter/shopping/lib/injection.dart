import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/products/data/datasources/product_remote_data_source.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/domain/usecases/get_product.dart';
import 'features/products/domain/usecases/get_products.dart';
import 'features/products/presentation/bloc/products_bloc.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/cart/domain/usecases/add_item.dart';
import 'features/cart/domain/usecases/clear_cart.dart';
import 'features/cart/domain/usecases/get_cart.dart';
import 'features/cart/domain/usecases/remove_item.dart';
import 'features/cart/domain/usecases/update_quantity.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  sl.registerLazySingleton<Dio>(() => Dio());

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl<Dio>()));

  // Repositories
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl<ProductRemoteDataSource>()));

  // Use cases
  sl.registerFactory(() => GetProducts(sl<ProductRepository>()));
  sl.registerFactory(() => GetProduct(sl<ProductRepository>()));

  // Bloc
  sl.registerFactory(
    () => ProductsBloc(
      getProducts: sl<GetProducts>(),
      getProduct: sl<GetProduct>(),
    ),
  );

  // Cart
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl());
  sl.registerFactory(() => GetCart(sl<CartRepository>()));
  sl.registerFactory(() => AddItem(sl<CartRepository>()));
  sl.registerFactory(() => RemoveItem(sl<CartRepository>()));
  sl.registerFactory(() => UpdateQuantity(sl<CartRepository>()));
  sl.registerFactory(() => ClearCart(sl<CartRepository>()));
  sl.registerLazySingleton(
    () => CartBloc(sl<CartRepository>()),
  );
}
