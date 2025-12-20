import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> searchMovies(String query, int page);
  Future<List<MovieModel>> getPopularMovies(int page);
}

@LazySingleton(as: MovieRemoteDataSource)
class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient apiClient;
  
  // TMDB API Key
  static const String apiKey = '8265bd1679663a7ea12ac168da84d2e8';

  MovieRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<MovieModel>> searchMovies(String query, int page) async {
    try {
      final response = await apiClient.searchMovies(apiKey, query, page);
      return response.results;
    } catch (e) {
      throw ServerException('Failed to search movies: ${e.toString()}');
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies(int page) async {
    try {
      final response = await apiClient.getPopularMovies(apiKey, page);
      return response.results;
    } catch (e) {
      throw ServerException('Failed to get popular movies: ${e.toString()}');
    }
  }
}