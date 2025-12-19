abstract class MovieEvent {}

class MovieLoadEvent implements MovieEvent {}

class MovieSearchEvent implements MovieEvent {
  final String query;
  MovieSearchEvent({required this.query});
}