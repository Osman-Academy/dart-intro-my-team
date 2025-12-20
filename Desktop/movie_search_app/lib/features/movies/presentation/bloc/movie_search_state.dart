import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/movie.dart';

part 'movie_search_state.freezed.dart';

@freezed
class MovieSearchState with _$MovieSearchState {
  const factory MovieSearchState.initial() = MovieSearchInitial;
  const factory MovieSearchState.loading() = MovieSearchLoading;
  const factory MovieSearchState.loaded(List<Movie> movies) = MovieSearchLoaded;
  const factory MovieSearchState.error(String message) = MovieSearchError;
}