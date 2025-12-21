import 'package:final_project/entities/video.dart';

abstract class VideoState {}
class VideoStateInitial implements VideoState {}
class VideoStateLoading implements VideoState {}
class VideoStateSuccess implements VideoState {
  final List<Video> videos;
  VideoStateSuccess({required this.videos});
}
