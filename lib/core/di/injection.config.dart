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
import 'package:string_search_app/data/datasource/product_remote_datasource.dart'
    as _i472;
import 'package:string_search_app/data/datasource/user_remote_datasource.dart'
    as _i252;
import 'package:string_search_app/data/repositories/product_repository_impl.dart'
    as _i960;
import 'package:string_search_app/data/repositories/user_repository_impl.dart'
    as _i941;
import 'package:string_search_app/domain/repositories/product_repository.dart'
    as _i395;
import 'package:string_search_app/domain/repositories/user_repository.dart'
    as _i448;
import 'package:string_search_app/domain/usercases/search_products.dart'
    as _i87;
import 'package:string_search_app/domain/usercases/search_users.dart' as _i899;
import 'package:string_search_app/presentation/bloc/search_bloc.dart' as _i93;

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
    gh.lazySingleton<_i472.ProductRemoteDataSource>(
        () => _i472.ProductRemoteDataSource());
    gh.lazySingleton<_i252.UserRemoteDataSource>(
        () => _i252.UserRemoteDataSource());
    gh.factory<_i395.ProductRepository>(
        () => _i960.ProductRepositoryImpl(gh<_i472.ProductRemoteDataSource>()));
    gh.factory<_i448.UserRepository>(
        () => _i941.UserRepositoryImpl(gh<_i252.UserRemoteDataSource>()));
    gh.factory<_i87.SearchProducts>(
        () => _i87.SearchProducts(gh<_i395.ProductRepository>()));
    gh.factory<_i899.SearchUsers>(
        () => _i899.SearchUsers(gh<_i448.UserRepository>()));
    gh.factory<_i93.SearchBloc>(() => _i93.SearchBloc(
          gh<_i899.SearchUsers>(),
          gh<_i87.SearchProducts>(),
        ));
    return this;
  }
}
