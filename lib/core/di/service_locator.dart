import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_search/features/movie/data/datasources/movie_remote_datasource.dart';
import 'package:movie_search/features/movie/data/datasources/movie_remote_datasource_impl.dart';
import 'package:movie_search/features/movie/domain/repositories/movie_repository.dart';
import '../../features/movie/data/repositories/movie_repository_impl.dart';
import '../../features/movie/domain/usecases/get_all_movies.dart';

final sl = GetIt.instance;

void setupDI() {
  // Dio
  sl.registerLazySingleton(() => Dio());

  // Datasource
  sl.registerLazySingleton<MovieRemoteDatasource>(
      () => MovieRemoteDatasourceImpl(sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(sl()));

  // Use case
  sl.registerLazySingleton(() => GetAllMovies(sl()));
}