import 'package:movie_search/features/movie/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getAllMovies();
}