import 'package:movie_search/models/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getAllMovies();
}