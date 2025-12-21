import '../models/movie_model.dart';

abstract class MovieRemoteDatasource {
  Future<List<MovieModel>> fetchAllMovies();
}
