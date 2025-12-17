// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:product_store_app/core/network/api_client.dart' as _i478;
import 'package:product_store_app/features/products/data/datasources/product_remote_datasource.dart'
    as _i246;
import 'package:product_store_app/features/products/data/repositories/product_repository_impl.dart'
    as _i2;
import 'package:product_store_app/features/products/domain/repositories/product_repository.dart'
    as _i984;
import 'package:product_store_app/features/products/domain/usecases/get_product_by_id.dart'
    as _i531;
import 'package:product_store_app/features/products/domain/usecases/get_products.dart'
    as _i861;
import 'package:product_store_app/features/products/domain/usecases/search_products.dart'
    as _i65;
import 'package:product_store_app/features/products/presentation/bloc/product_bloc.dart'
    as _i129;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i478.ApiClient>(() => _i478.ApiClient());
    gh.lazySingleton<_i246.ProductRemoteDataSource>(
        () => _i246.ProductRemoteDataSourceImpl(gh<_i478.ApiClient>()));
    gh.lazySingleton<_i984.ProductRepository>(
        () => _i2.ProductRepositoryImpl(gh<_i246.ProductRemoteDataSource>()));
    gh.lazySingleton<_i861.GetProducts>(
        () => _i861.GetProducts(gh<_i984.ProductRepository>()));
    gh.lazySingleton<_i531.GetProductById>(
        () => _i531.GetProductById(gh<_i984.ProductRepository>()));
    gh.lazySingleton<_i65.SearchProducts>(
        () => _i65.SearchProducts(gh<_i984.ProductRepository>()));
    gh.factory<_i129.ProductBloc>(() => _i129.ProductBloc(
          gh<_i861.GetProducts>(),
          gh<_i65.SearchProducts>(),
          gh<_i531.GetProductById>(),
        ));
    return this;
  }
}
