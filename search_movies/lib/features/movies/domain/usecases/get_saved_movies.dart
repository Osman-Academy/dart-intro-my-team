import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

@injectable
class GetSavedMovies {
  final MovieRepository repository;
  
  GetSavedMovies(this.repository);
  
  Future<Either<Failure, List<Movie>>> call() async {
    return await repository.getSavedMovies();
  }
}

@injectable
class GetPopularMovies {
  final MovieRepository repository;
  
  GetPopularMovies(this.repository);
  
  Future<Either<Failure, List<Movie>>> call(int page) async {
    return await repository.getPopularMovies(page);
  }
}