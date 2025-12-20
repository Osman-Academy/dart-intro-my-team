import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_search_event.freezed.dart';

@freezed
class MovieSearchEvent with _$MovieSearchEvent {
  const factory MovieSearchEvent.searchMovies(String query) = SearchMoviesEvent;
  const factory MovieSearchEvent.loadPopularMovies() = LoadPopularMoviesEvent;
  const factory MovieSearchEvent.clearSearch() = ClearSearchEvent;
}