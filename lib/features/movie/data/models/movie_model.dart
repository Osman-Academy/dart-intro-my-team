import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/movie.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  const MovieModel._();

  const factory MovieModel({
    @JsonKey(name: 'Title') required String title,
    @JsonKey(name: 'Year') required String year,
    @JsonKey(name: 'Plot') required String plot,
    @JsonKey(name: 'Poster') required String poster,
    @JsonKey(name: 'imdbRating') required String imdbRating,
    @JsonKey(name: 'imdbID') required String imdbID,
    @JsonKey(name: 'Actors') required String actors,
    @JsonKey(name: 'Awards') required String awards,
    @JsonKey(name: 'Language') required String language,
    @JsonKey(name: 'Country') required String country,
    @JsonKey(name: 'Metascore') required String metascore,
    @JsonKey(name: 'Rated') required String rated,
    @JsonKey(name: 'Director') required String director,
    @JsonKey(name: 'Writer') required String writer,
    @JsonKey(name: 'Genre') required String genre,
    @JsonKey(name: 'Runtime') required String runtime,
    @JsonKey(name: 'Released') required String released,
    @JsonKey(name: 'Images') @Default([]) List<String> images,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Movie toEntity() {
    return Movie(
      title: title,
      year: year,
      plot: plot,
      poster: poster,
      imdbRating: imdbRating,
      imdbID: imdbID,
      actors: actors,
      awards: awards,
      language: language,
      country: country,
      metascore: metascore,
      rated: rated,
      director: director,
      writer: writer,
      genre: genre,
      runtime: runtime,
      released: released,
      images: images,
    );
  }
}
