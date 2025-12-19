import 'package:dio/dio.dart';
import '../utils/constants.dart';

// Простой API клиент без Retrofit
class ApiClient {
  final Dio _dio;
  
  ApiClient(this._dio);
  
  // Поиск фильмов
  Future<Map<String, dynamic>> searchMovies(
    String apiKey,
    String query,
    int page,
  ) async {
    try {
      final response = await _dio.get(
        AppConstants.searchMoviesEndpoint,
        queryParameters: {
          'api_key': apiKey,
          'query': query,
          'page': page,
        },
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
  
  // Детали фильма
  Future<Map<String, dynamic>> getMovieDetails(
    int movieId,
    String apiKey,
  ) async {
    try {
      final response = await _dio.get(
        '${AppConstants.movieDetailsEndpoint}/$movieId',
        queryParameters: {
          'api_key': apiKey,
        },
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
  
  // Популярные фильмы
  Future<Map<String, dynamic>> getPopularMovies(
    String apiKey,
    int page,
  ) async {
    try {
      final response = await _dio.get(
        AppConstants.popularMoviesEndpoint,
        queryParameters: {
          'api_key': apiKey,
          'page': page,
        },
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}