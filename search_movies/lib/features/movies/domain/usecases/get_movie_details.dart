import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

@injectable
class GetMovieDetails {
  final MovieRepository repository;
  
  GetMovieDetails(this.repository);
  
  Future<Either<Failure, Movie>> call(int movieId) async {
    if (movieId <= 0) {
      return const Left(GeneralFailure('Invalid movie ID'));
    }
    
    return await repository.getMovieDetails(movieId);
  }
}