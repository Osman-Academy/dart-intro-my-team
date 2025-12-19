import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_details_event.freezed.dart';

@freezed
class MovieDetailsEvent with _$MovieDetailsEvent {
  const factory MovieDetailsEvent.loadDetails(int movieId) = LoadMovieDetailsEvent;
  const factory MovieDetailsEvent.toggleSave() = ToggleSaveEvent;
}