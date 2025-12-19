import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_local_datasource.dart';
import '../datasources/movie_remote_datasource.dart';
import '../models/movie_model.dart';

// Реализация репозитория
@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  
  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  
  @override
  Future<Either<Failure, List<Movie>>> searchMovies(
    String query,
    int page,
  ) async {
    try {
      final movieModels = await remoteDataSource.searchMovies(query, page);
      final movies = movieModels.map((model) => model.toEntity()).toList();
      
      // Проверяем какие фильмы сохранены
      for (var i = 0; i < movies.length; i++) {
        final isSaved = await localDataSource.isMovieSaved(movies[i].id);
        movies[i] = movies[i].copyWith(isSaved: isSaved);
      }
      
      return Right(movies);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Movie>> getMovieDetails(int movieId) async {
    try {
      final movieModel = await remoteDataSource.getMovieDetails(movieId);
      final movie = movieModel.toEntity();
      
      // проверяем сохранен ли
      final isSaved = await localDataSource.isMovieSaved(movieId);
      
      return Right(movie.copyWith(isSaved: isSaved));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies(int page) async {
    try {
      final movieModels = await remoteDataSource.getPopularMovies(page);
      final movies = movieModels.map((model) => model.toEntity()).toList();
      
      // проверяем сохраненные
      for (var i = 0; i < movies.length; i++) {
        final isSaved = await localDataSource.isMovieSaved(movies[i].id);
        movies[i] = movies[i].copyWith(isSaved: isSaved);
      }
      
      return Right(movies);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> saveMovie(Movie movie) async {
    try {
      final movieModel = MovieModel.fromEntity(movie);
      await localDataSource.saveMovie(movieModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> removeSavedMovie(int movieId) async {
    try {
      await localDataSource.removeMovie(movieId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Movie>>> getSavedMovies() async {
    try {
      final movieModels = await localDataSource.getSavedMovies();
      final movies = movieModels.map((model) => model.toEntity()).toList();
      return Right(movies);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, bool>> isMovieSaved(int movieId) async {
    try {
      final isSaved = await localDataSource.isMovieSaved(movieId);
      return Right(isSaved);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}