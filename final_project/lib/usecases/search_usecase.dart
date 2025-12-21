import 'package:final_project/entities/video.dart';
import 'package:final_project/repositories/video_repository.dart';
import 'package:final_project/repositories/video_repository_impl.dart';

class SearchUsecase {
  final VideoRepository videoRepo;
  SearchUsecase({required this.videoRepo});
  Future<List<Video>> call(String query) async {
    return await videoRepo.searchVideos(query);
  }
}