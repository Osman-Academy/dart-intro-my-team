import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
class Book with _$Book {
  factory Book({
    required String id,
    required String title,
    @Default([]) List<String> authors,
    @Default("") String description,
    @Default("") String thumbnail,
    @Default("") String publishedDate,
    @Default([]) List<String> categories,
    @Default(0.0) double averageRating,
    @Default("") String language,
    @Default(false) bool isFavorite,
  }) = _Book;

  factory Book.fromJson(Map<String, Object?> json) => _$BookFromJson(json);
}
