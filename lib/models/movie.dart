import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required String title,
    required String year,
    required String plot,
    required String poster,
    required String imdbRating,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}

extension MoviePosterFix on Movie {
  String get safePoster {
    if (poster.startsWith('http://')) {
      return poster.replaceFirst('http://', 'https://');
    }
    return poster;
  }
}
