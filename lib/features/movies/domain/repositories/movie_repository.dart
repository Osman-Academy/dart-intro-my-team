import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/movie.dart';

// Абстракция репозитория - контракт для data layer
abstract class MovieRepository {
  // Поиск фильмов по паттерну
  Future<Either<Failure, List<Movie>>> searchMovies(String query, int page);
  
  // Получить детали фильма
  Future<Either<Failure, Movie>> getMovieDetails(int movieId);
  
  // Популярные фильмы
  Future<Either<Failure, List<Movie>>> getPopularMovies(int page);
  
  // Сохранить фильм локально
  Future<Either<Failure, void>> saveMovie(Movie movie);
  
  // Удалить фильм из сохраненных
  Future<Either<Failure, void>> removeSavedMovie(int movieId);
  
  // Получить все сохраненные фильмы
  Future<Either<Failure, List<Movie>>> getSavedMovies();
  
  // Проверить сохранен ли фильм
  Future<Either<Failure, bool>> isMovieSaved(int movieId);
}