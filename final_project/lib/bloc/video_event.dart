abstract class VideoEvent {}
class VideoLoadEvent implements VideoEvent {}
class VideoViewEvent implements VideoEvent {
  String query;
  VideoViewEvent({required this.query});
}