import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';

// Entity для домена - чистая бизнес логика
@freezed
class Movie with _$Movie {
  const factory Movie({
    required int id,
    required String title,
    required String overview,
    @Default('') String posterPath,
    @Default('') String backdropPath,
    @Default(0.0) double voteAverage,
    @Default(0) int voteCount,
    @Default('') String releaseDate,
    @Default([]) List<int> genreIds,
    @Default(false) bool isSaved, // для отметки сохраненных фильмов
  }) = _Movie;
}