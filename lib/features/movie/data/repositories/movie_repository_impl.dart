import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_datasource.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource remoteDatasource;

  MovieRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Movie>> getAllMovies() async {
    final models = await remoteDatasource.fetchAllMovies();
    return models.map((e) => e.toEntity()).toList();
  }
}
