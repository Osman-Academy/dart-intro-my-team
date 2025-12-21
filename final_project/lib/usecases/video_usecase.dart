import 'package:final_project/entities/video.dart';
import 'package:final_project/repositories/video_repository.dart';

class VideoUsecase {
  VideoRepository videoRepo;
  VideoUsecase({required this.videoRepo});
  Future<List<Video>> call() async {
    return await videoRepo.getVideos();
  }
}