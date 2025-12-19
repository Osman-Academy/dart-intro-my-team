import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/movie.dart';

part 'movie_details_state.freezed.dart';

@freezed
class MovieDetailsState with _$MovieDetailsState {
  const factory MovieDetailsState.initial() = MovieDetailsInitial;
  const factory MovieDetailsState.loading() = MovieDetailsLoading;
  const factory MovieDetailsState.loaded(Movie movie) = MovieDetailsLoaded;
  const factory MovieDetailsState.error(String message) = MovieDetailsError;
}