import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

@injectable
class SaveMovie {
  final MovieRepository repository;
  
  SaveMovie(this.repository);
  
  Future<Either<Failure, void>> call(Movie movie) async {
    return await repository.saveMovie(movie);
  }
}

@injectable
class RemoveSavedMovie {
  final MovieRepository repository;
  
  RemoveSavedMovie(this.repository);
  
  Future<Either<Failure, void>> call(int movieId) async {
    return await repository.removeSavedMovie(movieId);
  }
}