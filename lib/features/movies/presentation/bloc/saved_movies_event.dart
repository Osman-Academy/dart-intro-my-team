part of 'saved_movies_bloc.dart';

@freezed
class SavedMoviesEvent with _$SavedMoviesEvent {
  const factory SavedMoviesEvent.loadSaved() = LoadSavedMoviesEvent;
  const factory SavedMoviesEvent.addMovie(Movie movie) = AddMovieEvent;
  const factory SavedMoviesEvent.removeMovie(int movieId) = RemoveMovieEvent;
}