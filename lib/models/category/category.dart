import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category {
  factory Category({
    required String id,
    required String name,
    @Default([]) List<String> bookIds,
    @Default(false) bool isDefault,
  }) = _Category;

  factory Category.fromJson(Map<String, Object?> json) => _$CategoryFromJson(json);
}