import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/movie.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

// Model для data layer - работа с JSON
@freezed
class MovieModel with _$MovieModel {
  const MovieModel._();
  
  const factory MovieModel({
    required int id,
    required String title,
    required String overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'vote_average') @Default(0.0) double voteAverage,
    @JsonKey(name: 'vote_count') @Default(0) int voteCount,
    @JsonKey(name: 'release_date') @Default('') String releaseDate,
    @JsonKey(name: 'genre_ids') @Default([]) List<int> genreIds,
    @Default(false) bool isSaved,
  }) = _MovieModel;
  
  // Десериализация из JSON
  factory MovieModel.fromJson(Map<String, dynamic> json) => 
      _$MovieModelFromJson(json);
  
  // Конвертация в entity
  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath ?? '',
      backdropPath: backdropPath ?? '',
      voteAverage: voteAverage,
      voteCount: voteCount,
      releaseDate: releaseDate,
      genreIds: genreIds,
      isSaved: isSaved,
    );
  }
  
  // Конвертация из entity (для сохранения)
  factory MovieModel.fromEntity(Movie movie) {
    return MovieModel(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      posterPath: movie.posterPath.isEmpty ? null : movie.posterPath,
      backdropPath: movie.backdropPath.isEmpty ? null : movie.backdropPath,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
      releaseDate: movie.releaseDate,
      genreIds: movie.genreIds,
      isSaved: movie.isSaved,
    );
  }
}