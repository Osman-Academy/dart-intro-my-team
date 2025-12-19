// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieImpl _$$MovieImplFromJson(Map<String, dynamic> json) => _$MovieImpl(
  title: json['title'] as String,
  year: json['year'] as String,
  plot: json['plot'] as String,
  poster: json['poster'] as String,
  imdbRating: json['imdbRating'] as String,
);

Map<String, dynamic> _$$MovieImplToJson(_$MovieImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'year': instance.year,
      'plot': instance.plot,
      'poster': instance.poster,
      'imdbRating': instance.imdbRating,
    };
