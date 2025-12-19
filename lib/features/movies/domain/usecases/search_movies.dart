import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

// Use case для поиска фильмов
@injectable
class SearchMovies {
  final MovieRepository repository;
  
  SearchMovies(this.repository);
  
  Future<Either<Failure, List<Movie>>> call(String query, int page) async {
    // валидация запроса
    if (query.trim().isEmpty) {
      return const Left(GeneralFailure('Search query cannot be empty'));
    }
    
    return await repository.searchMovies(query, page);
  }
}