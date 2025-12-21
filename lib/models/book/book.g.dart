// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookImpl _$$BookImplFromJson(Map<String, dynamic> json) => _$BookImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  authors:
      (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  description: json['description'] as String? ?? "",
  thumbnail: json['thumbnail'] as String? ?? "",
  publishedDate: json['publishedDate'] as String? ?? "",
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
  language: json['language'] as String? ?? "",
  isFavorite: json['isFavorite'] as bool? ?? false,
);

Map<String, dynamic> _$$BookImplToJson(_$BookImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authors': instance.authors,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'publishedDate': instance.publishedDate,
      'categories': instance.categories,
      'averageRating': instance.averageRating,
      'language': instance.language,
      'isFavorite': instance.isFavorite,
    };
