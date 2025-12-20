// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieImpl _$$MovieImplFromJson(Map<String, dynamic> json) => _$MovieImpl(
  title: json['Title'] as String,
  year: json['Year'] as String,
  plot: json['Plot'] as String,
  poster: json['Poster'] as String,
  imdbRating: json['imdbRating'] as String,
);

Map<String, dynamic> _$$MovieImplToJson(_$MovieImpl instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'Plot': instance.plot,
      'Poster': instance.poster,
      'imdbRating': instance.imdbRating,
    };
