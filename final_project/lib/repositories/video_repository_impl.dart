
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:final_project/entities/video.dart';
import 'package:final_project/models/video_dto.dart';
import 'package:final_project/repositories/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  Dio dio = Dio();
  @override
  Future<List<Video>> getVideos() async {
    final response = await dio.get("https://dummyjson.com/c/d174-78e1-432c-be6e");
    final List<dynamic> data = response.data;
    return data.map((e) => VideoDto.fromJson(e).toEntity()).toList();
  }
}
