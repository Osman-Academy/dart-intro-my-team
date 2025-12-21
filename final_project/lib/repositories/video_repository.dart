import 'package:final_project/entities/video.dart';

abstract class VideoRepository {
  Future<List<Video>> getVideos();
}
