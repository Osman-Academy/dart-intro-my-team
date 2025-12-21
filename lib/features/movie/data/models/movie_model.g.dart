// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieModelImpl _$$MovieModelImplFromJson(Map<String, dynamic> json) =>
    _$MovieModelImpl(
      title: json['Title'] as String,
      year: json['Year'] as String,
      plot: json['Plot'] as String,
      poster: json['Poster'] as String,
      imdbRating: json['imdbRating'] as String,
      imdbID: json['imdbID'] as String,
      actors: json['Actors'] as String,
      awards: json['Awards'] as String,
      language: json['Language'] as String,
      country: json['Country'] as String,
      metascore: json['Metascore'] as String,
      rated: json['Rated'] as String,
      director: json['Director'] as String,
      writer: json['Writer'] as String,
      genre: json['Genre'] as String,
      runtime: json['Runtime'] as String,
      released: json['Released'] as String,
      images:
          (json['Images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MovieModelImplToJson(_$MovieModelImpl instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'Plot': instance.plot,
      'Poster': instance.poster,
      'imdbRating': instance.imdbRating,
      'imdbID': instance.imdbID,
      'Actors': instance.actors,
      'Awards': instance.awards,
      'Language': instance.language,
      'Country': instance.country,
      'Metascore': instance.metascore,
      'Rated': instance.rated,
      'Director': instance.director,
      'Writer': instance.writer,
      'Genre': instance.genre,
      'Runtime': instance.runtime,
      'Released': instance.released,
      'Images': instance.images,
    };
