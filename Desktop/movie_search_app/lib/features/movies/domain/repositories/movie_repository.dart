import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> searchMovies(String query, int page);
  Future<Either<Failure, List<Movie>>> getPopularMovies(int page);
}