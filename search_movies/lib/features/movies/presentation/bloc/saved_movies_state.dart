part of 'saved_movies_bloc.dart';

@freezed
class SavedMoviesState with _$SavedMoviesState {
  const factory SavedMoviesState.initial() = SavedMoviesInitial;
  const factory SavedMoviesState.loading() = SavedMoviesLoading;
  const factory SavedMoviesState.loaded(List<Movie> movies) = SavedMoviesLoaded;
  const factory SavedMoviesState.error(String message) = SavedMoviesError;
}