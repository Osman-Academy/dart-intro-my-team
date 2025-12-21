import 'dart:convert';
import 'package:dio/dio.dart';
import 'movie_remote_datasource.dart';
import '../models/movie_model.dart';

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final Dio dio;

  MovieRemoteDatasourceImpl(this.dio);

  @override
  Future<List<MovieModel>> fetchAllMovies() async {
    final response = await dio.get(
      'https://gist.githubusercontent.com/saniyusuf/406b843afdfb9c6a86e25753fe2761f4/raw/Film.JSON',
    );

    final rawData = response.data;
    final List<dynamic> data = rawData is String ? jsonDecode(rawData) : rawData;

    return data.map((e) => MovieModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
