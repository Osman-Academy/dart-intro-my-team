import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_search/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_search/features/movie/presentation/bloc/movie_bloc.dart';
import '../../features/movie/data/repositories/movie_repository_impl.dart';
import '../../features/movie/domain/usecases/get_all_movies.dart';

final sl = GetIt.instance;

void setupDI() {
  // Dio client
  sl.registerLazySingleton(() => Dio());

  // Repository
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl()));

  // Use case
  sl.registerLazySingleton(() => GetAllMovies(sl()));

  // Bloc
  sl.registerFactory(() => MovieBloc(getAllMovies: sl()));
}
