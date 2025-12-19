import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_search_event.freezed.dart';

@freezed
class MovieSearchEvent with _$MovieSearchEvent {
  const factory MovieSearchEvent.searchMovies(String query) = SearchMoviesEvent;
  const factory MovieSearchEvent.loadPopular() = LoadPopularMoviesEvent;
  const factory MovieSearchEvent.loadMore() = LoadMoreMoviesEvent;
  const factory MovieSearchEvent.clearSearch() = ClearSearchEvent;
}