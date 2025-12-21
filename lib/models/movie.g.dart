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
  rated: json['Rated'] as String?,
  released: json['Released'] as String?,
  runtime: json['Runtime'] as String?,
  genre: json['Genre'] as String?,
  director: json['Director'] as String?,
  writer: json['Writer'] as String?,
  actors: json['Actors'] as String?,
  language: json['Language'] as String?,
  country: json['Country'] as String?,
  awards: json['Awards'] as String?,
  metascore: json['Metascore'] as String?,
  imdbVotes: json['imdbVotes'] as String?,
  imdbID: json['imdbID'] as String,
  images: (json['Images'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$$MovieImplToJson(_$MovieImpl instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'Plot': instance.plot,
      'Poster': instance.poster,
      'imdbRating': instance.imdbRating,
      'Rated': instance.rated,
      'Released': instance.released,
      'Runtime': instance.runtime,
      'Genre': instance.genre,
      'Director': instance.director,
      'Writer': instance.writer,
      'Actors': instance.actors,
      'Language': instance.language,
      'Country': instance.country,
      'Awards': instance.awards,
      'Metascore': instance.metascore,
      'imdbVotes': instance.imdbVotes,
      'imdbID': instance.imdbID,
      'Images': instance.images,
    };
