
import 'package:final_project/models/video.dart';

abstract class VideoRepository {
  List<Video> getVideos();
}

var dataFromServer = [
  {
    "title": "Артем Ауткоров - "'Реанимация и Настолки'" | Стендап 2025",
    "author": "Артем Ауткоров"
  }
];

class VideoRepositoryImpl implements VideoRepository {
  @override
  List<Video> getVideos() {
    return dataFromServer.map((e) => Video.fromJson(e)).toList();
  }
}
