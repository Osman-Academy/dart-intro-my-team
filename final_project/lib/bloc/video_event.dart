abstract class VideoEvent {}
class VideoLoadEvent implements VideoEvent {}
class VideoViewEvent implements VideoEvent {
  String search;
  VideoViewEvent({required this.search});
}