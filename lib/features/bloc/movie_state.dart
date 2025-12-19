import 'package:movie_search/models/movie.dart';

abstract class MovieState {}

class MovieStateInitial implements MovieState {}

class MovieStateLoading implements MovieState {}

class MovieStateLoaded implements MovieState {
  final List<Movie> allMovies;
  final List<Movie> displayedMovies;
  MovieStateLoaded({required this.allMovies, required this.displayedMovies});
}

class MovieStateError implements MovieState {
  final String message;
  MovieStateError({required this.message});
}