// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movie_search_app/core/network/api_client.dart' as _i389;
import 'package:movie_search_app/features/movies/data/datasources/movie_remote_datasource.dart'
    as _i454;
import 'package:movie_search_app/features/movies/data/repositories/movie_repository_impl.dart'
    as _i948;
import 'package:movie_search_app/features/movies/domain/repositories/movie_repository.dart'
    as _i636;
import 'package:movie_search_app/features/movies/domain/usecases/search_movies.dart'
    as _i655;
import 'package:movie_search_app/features/movies/presentation/bloc/movie_search_bloc.dart'
    as _i319;

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
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i389.ApiClient>(
        () => networkModule.apiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i454.MovieRemoteDataSource>(
        () => _i454.MovieRemoteDataSourceImpl(gh<_i389.ApiClient>()));
    gh.lazySingleton<_i636.MovieRepository>(
        () => _i948.MovieRepositoryImpl(gh<_i454.MovieRemoteDataSource>()));
    gh.lazySingleton<_i655.SearchMovies>(
        () => _i655.SearchMovies(gh<_i636.MovieRepository>()));
    gh.factory<_i319.MovieSearchBloc>(
        () => _i319.MovieSearchBloc(gh<_i655.SearchMovies>()));
    return this;
  }
}

class _$NetworkModule extends _i389.NetworkModule {}
