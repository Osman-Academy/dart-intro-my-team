import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:movie_search/repositories/movie_repository.dart';
import 'package:movie_search/models/movie.dart';

class MovieRepositoryRemote implements MovieRepository {
  final Dio _dio = Dio();

  @override
  Future<List<Movie>> getAllMovies() async {
    try {
      final response = await _dio.get(
        'https://gist.githubusercontent.com/saniyusuf/406b843afdfb9c6a86e25753fe2761f4/raw/Film.JSON',
      );

      final dynamic rawData = response.data;
      
      final List<dynamic> data = rawData is String
          ? jsonDecode(rawData) as List<dynamic>
          : rawData as List<dynamic>;

      return data
          .map((json) => Movie.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e, stack) {
      print(stack);
      throw Exception('Failed to load movies: $e');
    }
  }
}
