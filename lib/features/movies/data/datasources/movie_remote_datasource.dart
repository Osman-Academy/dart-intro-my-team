import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/movie_model.dart';

// Интерфейс для remote data source
abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> searchMovies(String query, int page);
  Future<MovieModel> getMovieDetails(int movieId);
  Future<List<MovieModel>> getPopularMovies(int page);
}

// Реализация remote data source
@LazySingleton(as: MovieRemoteDataSource)
class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient apiClient;
  
  MovieRemoteDataSourceImpl(this.apiClient);
  
  @override
  Future<List<MovieModel>> searchMovies(String query, int page) async {
    try {
      final response = await apiClient.searchMovies(
        AppConstants.apiKey,
        query,
        page,
      );
      
      final results = response['results'] as List;
      return results.map((json) => MovieModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('Error searching movies: ${e.toString()}');
    }
  }
  
  @override
  Future<MovieModel> getMovieDetails(int movieId) async {
    try {
      final response = await apiClient.getMovieDetails(
        movieId,
        AppConstants.apiKey,
      );
      
      return MovieModel.fromJson(response);
    } catch (e) {
      throw ServerException('Error getting movie details: ${e.toString()}');
    }
  }
  
  @override
  Future<List<MovieModel>> getPopularMovies(int page) async {
    try {
      final response = await apiClient.getPopularMovies(
        AppConstants.apiKey,
        page,
      );
      
      final results = response['results'] as List;
      return results.map((json) => MovieModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('Error getting popular movies: ${e.toString()}');
    }
  }
}