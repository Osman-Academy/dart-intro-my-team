import 'dart:convert';
import 'package:dio/dio.dart';

import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio dio;

  MovieRepositoryImpl(this.dio);

  @override
  Future<List<Movie>> getAllMovies() async {
    final response = await dio.get(
      'https://gist.githubusercontent.com/saniyusuf/406b843afdfb9c6a86e25753fe2761f4/raw/Film.JSON',
    );

    final rawData = response.data;
    final List<dynamic> data = rawData is String
        ? jsonDecode(rawData)
        : rawData;

    final models = data
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return models.map((e) => e.toEntity()).toList();
  }
}
