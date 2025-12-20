import 'package:get_it/get_it.dart';
import 'package:movie_search/repositories/movie_repository.dart';
import 'package:movie_search/repositories/movie_repository_remote.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryRemote());
}