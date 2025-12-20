import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

@lazySingleton
class SearchMovies extends UseCase<List<Movie>, SearchMoviesParams> {
  final MovieRepository repository;

  SearchMovies(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> call(SearchMoviesParams params) async {
    if (params.query.isEmpty) {
      return repository.getPopularMovies(params.page);
    }
    return repository.searchMovies(params.query, params.page);
  }
}

class SearchMoviesParams {
  final String query;
  final int page;

  SearchMoviesParams({
    required this.query,
    this.page = 1,
  });
}