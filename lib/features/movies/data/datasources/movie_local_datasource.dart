import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/movie_model.dart';

// Интерфейс для local data source
abstract class MovieLocalDataSource {
  Future<void> saveMovie(MovieModel movie);
  Future<void> removeMovie(int movieId);
  Future<List<MovieModel>> getSavedMovies();
  Future<bool> isMovieSaved(int movieId);
}

// Реализация local data source
@LazySingleton(as: MovieLocalDataSource)
class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences sharedPreferences;
  
  MovieLocalDataSourceImpl(this.sharedPreferences);
  
  @override
  Future<void> saveMovie(MovieModel movie) async {
    try {
      final movies = await getSavedMovies();
      
      // проверяем есть ли уже такой фильм
      final exists = movies.any((m) => m.id == movie.id);
      if (!exists) {
        movies.add(movie.copyWith(isSaved: true));
        await _saveMoviesToPrefs(movies);
      }
    } catch (e) {
      throw CacheException('Failed to save movie: ${e.toString()}');
    }
  }
  
  @override
  Future<void> removeMovie(int movieId) async {
    try {
      final movies = await getSavedMovies();
      movies.removeWhere((movie) => movie.id == movieId);
      await _saveMoviesToPrefs(movies);
    } catch (e) {
      throw CacheException('Failed to remove movie: ${e.toString()}');
    }
  }
  
  @override
  Future<List<MovieModel>> getSavedMovies() async {
    try {
      final jsonString = sharedPreferences.getString(AppConstants.savedMoviesKey);
      
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((json) => MovieModel.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      throw CacheException('Failed to get saved movies: ${e.toString()}');
    }
  }
  
  @override
  Future<bool> isMovieSaved(int movieId) async {
    try {
      final movies = await getSavedMovies();
      return movies.any((movie) => movie.id == movieId);
    } catch (e) {
      return false;
    }
  }
  
  // Вспомогательная функция для сохранения
  Future<void> _saveMoviesToPrefs(List<MovieModel> movies) async {
    final jsonList = movies.map((movie) => movie.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await sharedPreferences.setString(AppConstants.savedMoviesKey, jsonString);
  }
}