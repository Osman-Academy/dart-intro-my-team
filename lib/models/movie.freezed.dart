// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return _Movie.fromJson(json);
}

/// @nodoc
mixin _$Movie {
  @JsonKey(name: 'Title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'Year')
  String get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'Plot')
  String get plot => throw _privateConstructorUsedError;
  @JsonKey(name: 'Poster')
  String get poster => throw _privateConstructorUsedError;
  @JsonKey(name: 'imdbRating')
  String get imdbRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'Rated')
  String? get rated => throw _privateConstructorUsedError;
  @JsonKey(name: 'Released')
  String? get released => throw _privateConstructorUsedError;
  @JsonKey(name: 'Runtime')
  String? get runtime => throw _privateConstructorUsedError;
  @JsonKey(name: 'Genre')
  String? get genre => throw _privateConstructorUsedError;
  @JsonKey(name: 'Director')
  String? get director => throw _privateConstructorUsedError;
  @JsonKey(name: 'Writer')
  String? get writer => throw _privateConstructorUsedError;
  @JsonKey(name: 'Actors')
  String? get actors => throw _privateConstructorUsedError;
  @JsonKey(name: 'Language')
  String? get language => throw _privateConstructorUsedError;
  @JsonKey(name: 'Country')
  String? get country => throw _privateConstructorUsedError;
  @JsonKey(name: 'Awards')
  String? get awards => throw _privateConstructorUsedError;
  @JsonKey(name: 'Metascore')
  String? get metascore => throw _privateConstructorUsedError;
  @JsonKey(name: 'imdbVotes')
  String? get imdbVotes => throw _privateConstructorUsedError;
  @JsonKey(name: 'imdbID')
  String get imdbID => throw _privateConstructorUsedError;
  @JsonKey(name: 'Images')
  List<String>? get images => throw _privateConstructorUsedError;

  /// Serializes this Movie to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieCopyWith<Movie> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieCopyWith<$Res> {
  factory $MovieCopyWith(Movie value, $Res Function(Movie) then) =
      _$MovieCopyWithImpl<$Res, Movie>;
  @useResult
  $Res call({
    @JsonKey(name: 'Title') String title,
    @JsonKey(name: 'Year') String year,
    @JsonKey(name: 'Plot') String plot,
    @JsonKey(name: 'Poster') String poster,
    @JsonKey(name: 'imdbRating') String imdbRating,
    @JsonKey(name: 'Rated') String? rated,
    @JsonKey(name: 'Released') String? released,
    @JsonKey(name: 'Runtime') String? runtime,
    @JsonKey(name: 'Genre') String? genre,
    @JsonKey(name: 'Director') String? director,
    @JsonKey(name: 'Writer') String? writer,
    @JsonKey(name: 'Actors') String? actors,
    @JsonKey(name: 'Language') String? language,
    @JsonKey(name: 'Country') String? country,
    @JsonKey(name: 'Awards') String? awards,
    @JsonKey(name: 'Metascore') String? metascore,
    @JsonKey(name: 'imdbVotes') String? imdbVotes,
    @JsonKey(name: 'imdbID') String imdbID,
    @JsonKey(name: 'Images') List<String>? images,
  });
}

/// @nodoc
class _$MovieCopyWithImpl<$Res, $Val extends Movie>
    implements $MovieCopyWith<$Res> {
  _$MovieCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? year = null,
    Object? plot = null,
    Object? poster = null,
    Object? imdbRating = null,
    Object? rated = freezed,
    Object? released = freezed,
    Object? runtime = freezed,
    Object? genre = freezed,
    Object? director = freezed,
    Object? writer = freezed,
    Object? actors = freezed,
    Object? language = freezed,
    Object? country = freezed,
    Object? awards = freezed,
    Object? metascore = freezed,
    Object? imdbVotes = freezed,
    Object? imdbID = null,
    Object? images = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as String,
            plot: null == plot
                ? _value.plot
                : plot // ignore: cast_nullable_to_non_nullable
                      as String,
            poster: null == poster
                ? _value.poster
                : poster // ignore: cast_nullable_to_non_nullable
                      as String,
            imdbRating: null == imdbRating
                ? _value.imdbRating
                : imdbRating // ignore: cast_nullable_to_non_nullable
                      as String,
            rated: freezed == rated
                ? _value.rated
                : rated // ignore: cast_nullable_to_non_nullable
                      as String?,
            released: freezed == released
                ? _value.released
                : released // ignore: cast_nullable_to_non_nullable
                      as String?,
            runtime: freezed == runtime
                ? _value.runtime
                : runtime // ignore: cast_nullable_to_non_nullable
                      as String?,
            genre: freezed == genre
                ? _value.genre
                : genre // ignore: cast_nullable_to_non_nullable
                      as String?,
            director: freezed == director
                ? _value.director
                : director // ignore: cast_nullable_to_non_nullable
                      as String?,
            writer: freezed == writer
                ? _value.writer
                : writer // ignore: cast_nullable_to_non_nullable
                      as String?,
            actors: freezed == actors
                ? _value.actors
                : actors // ignore: cast_nullable_to_non_nullable
                      as String?,
            language: freezed == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String?,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            awards: freezed == awards
                ? _value.awards
                : awards // ignore: cast_nullable_to_non_nullable
                      as String?,
            metascore: freezed == metascore
                ? _value.metascore
                : metascore // ignore: cast_nullable_to_non_nullable
                      as String?,
            imdbVotes: freezed == imdbVotes
                ? _value.imdbVotes
                : imdbVotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            imdbID: null == imdbID
                ? _value.imdbID
                : imdbID // ignore: cast_nullable_to_non_nullable
                      as String,
            images: freezed == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MovieImplCopyWith<$Res> implements $MovieCopyWith<$Res> {
  factory _$$MovieImplCopyWith(
    _$MovieImpl value,
    $Res Function(_$MovieImpl) then,
  ) = __$$MovieImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'Title') String title,
    @JsonKey(name: 'Year') String year,
    @JsonKey(name: 'Plot') String plot,
    @JsonKey(name: 'Poster') String poster,
    @JsonKey(name: 'imdbRating') String imdbRating,
    @JsonKey(name: 'Rated') String? rated,
    @JsonKey(name: 'Released') String? released,
    @JsonKey(name: 'Runtime') String? runtime,
    @JsonKey(name: 'Genre') String? genre,
    @JsonKey(name: 'Director') String? director,
    @JsonKey(name: 'Writer') String? writer,
    @JsonKey(name: 'Actors') String? actors,
    @JsonKey(name: 'Language') String? language,
    @JsonKey(name: 'Country') String? country,
    @JsonKey(name: 'Awards') String? awards,
    @JsonKey(name: 'Metascore') String? metascore,
    @JsonKey(name: 'imdbVotes') String? imdbVotes,
    @JsonKey(name: 'imdbID') String imdbID,
    @JsonKey(name: 'Images') List<String>? images,
  });
}

/// @nodoc
class __$$MovieImplCopyWithImpl<$Res>
    extends _$MovieCopyWithImpl<$Res, _$MovieImpl>
    implements _$$MovieImplCopyWith<$Res> {
  __$$MovieImplCopyWithImpl(
    _$MovieImpl _value,
    $Res Function(_$MovieImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? year = null,
    Object? plot = null,
    Object? poster = null,
    Object? imdbRating = null,
    Object? rated = freezed,
    Object? released = freezed,
    Object? runtime = freezed,
    Object? genre = freezed,
    Object? director = freezed,
    Object? writer = freezed,
    Object? actors = freezed,
    Object? language = freezed,
    Object? country = freezed,
    Object? awards = freezed,
    Object? metascore = freezed,
    Object? imdbVotes = freezed,
    Object? imdbID = null,
    Object? images = freezed,
  }) {
    return _then(
      _$MovieImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as String,
        plot: null == plot
            ? _value.plot
            : plot // ignore: cast_nullable_to_non_nullable
                  as String,
        poster: null == poster
            ? _value.poster
            : poster // ignore: cast_nullable_to_non_nullable
                  as String,
        imdbRating: null == imdbRating
            ? _value.imdbRating
            : imdbRating // ignore: cast_nullable_to_non_nullable
                  as String,
        rated: freezed == rated
            ? _value.rated
            : rated // ignore: cast_nullable_to_non_nullable
                  as String?,
        released: freezed == released
            ? _value.released
            : released // ignore: cast_nullable_to_non_nullable
                  as String?,
        runtime: freezed == runtime
            ? _value.runtime
            : runtime // ignore: cast_nullable_to_non_nullable
                  as String?,
        genre: freezed == genre
            ? _value.genre
            : genre // ignore: cast_nullable_to_non_nullable
                  as String?,
        director: freezed == director
            ? _value.director
            : director // ignore: cast_nullable_to_non_nullable
                  as String?,
        writer: freezed == writer
            ? _value.writer
            : writer // ignore: cast_nullable_to_non_nullable
                  as String?,
        actors: freezed == actors
            ? _value.actors
            : actors // ignore: cast_nullable_to_non_nullable
                  as String?,
        language: freezed == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String?,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        awards: freezed == awards
            ? _value.awards
            : awards // ignore: cast_nullable_to_non_nullable
                  as String?,
        metascore: freezed == metascore
            ? _value.metascore
            : metascore // ignore: cast_nullable_to_non_nullable
                  as String?,
        imdbVotes: freezed == imdbVotes
            ? _value.imdbVotes
            : imdbVotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        imdbID: null == imdbID
            ? _value.imdbID
            : imdbID // ignore: cast_nullable_to_non_nullable
                  as String,
        images: freezed == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieImpl implements _Movie {
  const _$MovieImpl({
    @JsonKey(name: 'Title') required this.title,
    @JsonKey(name: 'Year') required this.year,
    @JsonKey(name: 'Plot') required this.plot,
    @JsonKey(name: 'Poster') required this.poster,
    @JsonKey(name: 'imdbRating') required this.imdbRating,
    @JsonKey(name: 'Rated') this.rated,
    @JsonKey(name: 'Released') this.released,
    @JsonKey(name: 'Runtime') this.runtime,
    @JsonKey(name: 'Genre') this.genre,
    @JsonKey(name: 'Director') this.director,
    @JsonKey(name: 'Writer') this.writer,
    @JsonKey(name: 'Actors') this.actors,
    @JsonKey(name: 'Language') this.language,
    @JsonKey(name: 'Country') this.country,
    @JsonKey(name: 'Awards') this.awards,
    @JsonKey(name: 'Metascore') this.metascore,
    @JsonKey(name: 'imdbVotes') this.imdbVotes,
    @JsonKey(name: 'imdbID') required this.imdbID,
    @JsonKey(name: 'Images') final List<String>? images,
  }) : _images = images;

  factory _$MovieImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieImplFromJson(json);

  @override
  @JsonKey(name: 'Title')
  final String title;
  @override
  @JsonKey(name: 'Year')
  final String year;
  @override
  @JsonKey(name: 'Plot')
  final String plot;
  @override
  @JsonKey(name: 'Poster')
  final String poster;
  @override
  @JsonKey(name: 'imdbRating')
  final String imdbRating;
  @override
  @JsonKey(name: 'Rated')
  final String? rated;
  @override
  @JsonKey(name: 'Released')
  final String? released;
  @override
  @JsonKey(name: 'Runtime')
  final String? runtime;
  @override
  @JsonKey(name: 'Genre')
  final String? genre;
  @override
  @JsonKey(name: 'Director')
  final String? director;
  @override
  @JsonKey(name: 'Writer')
  final String? writer;
  @override
  @JsonKey(name: 'Actors')
  final String? actors;
  @override
  @JsonKey(name: 'Language')
  final String? language;
  @override
  @JsonKey(name: 'Country')
  final String? country;
  @override
  @JsonKey(name: 'Awards')
  final String? awards;
  @override
  @JsonKey(name: 'Metascore')
  final String? metascore;
  @override
  @JsonKey(name: 'imdbVotes')
  final String? imdbVotes;
  @override
  @JsonKey(name: 'imdbID')
  final String imdbID;
  final List<String>? _images;
  @override
  @JsonKey(name: 'Images')
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Movie(title: $title, year: $year, plot: $plot, poster: $poster, imdbRating: $imdbRating, rated: $rated, released: $released, runtime: $runtime, genre: $genre, director: $director, writer: $writer, actors: $actors, language: $language, country: $country, awards: $awards, metascore: $metascore, imdbVotes: $imdbVotes, imdbID: $imdbID, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.plot, plot) || other.plot == plot) &&
            (identical(other.poster, poster) || other.poster == poster) &&
            (identical(other.imdbRating, imdbRating) ||
                other.imdbRating == imdbRating) &&
            (identical(other.rated, rated) || other.rated == rated) &&
            (identical(other.released, released) ||
                other.released == released) &&
            (identical(other.runtime, runtime) || other.runtime == runtime) &&
            (identical(other.genre, genre) || other.genre == genre) &&
            (identical(other.director, director) ||
                other.director == director) &&
            (identical(other.writer, writer) || other.writer == writer) &&
            (identical(other.actors, actors) || other.actors == actors) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.awards, awards) || other.awards == awards) &&
            (identical(other.metascore, metascore) ||
                other.metascore == metascore) &&
            (identical(other.imdbVotes, imdbVotes) ||
                other.imdbVotes == imdbVotes) &&
            (identical(other.imdbID, imdbID) || other.imdbID == imdbID) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    title,
    year,
    plot,
    poster,
    imdbRating,
    rated,
    released,
    runtime,
    genre,
    director,
    writer,
    actors,
    language,
    country,
    awards,
    metascore,
    imdbVotes,
    imdbID,
    const DeepCollectionEquality().hash(_images),
  ]);

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieImplCopyWith<_$MovieImpl> get copyWith =>
      __$$MovieImplCopyWithImpl<_$MovieImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieImplToJson(this);
  }
}

abstract class _Movie implements Movie {
  const factory _Movie({
    @JsonKey(name: 'Title') required final String title,
    @JsonKey(name: 'Year') required final String year,
    @JsonKey(name: 'Plot') required final String plot,
    @JsonKey(name: 'Poster') required final String poster,
    @JsonKey(name: 'imdbRating') required final String imdbRating,
    @JsonKey(name: 'Rated') final String? rated,
    @JsonKey(name: 'Released') final String? released,
    @JsonKey(name: 'Runtime') final String? runtime,
    @JsonKey(name: 'Genre') final String? genre,
    @JsonKey(name: 'Director') final String? director,
    @JsonKey(name: 'Writer') final String? writer,
    @JsonKey(name: 'Actors') final String? actors,
    @JsonKey(name: 'Language') final String? language,
    @JsonKey(name: 'Country') final String? country,
    @JsonKey(name: 'Awards') final String? awards,
    @JsonKey(name: 'Metascore') final String? metascore,
    @JsonKey(name: 'imdbVotes') final String? imdbVotes,
    @JsonKey(name: 'imdbID') required final String imdbID,
    @JsonKey(name: 'Images') final List<String>? images,
  }) = _$MovieImpl;

  factory _Movie.fromJson(Map<String, dynamic> json) = _$MovieImpl.fromJson;

  @override
  @JsonKey(name: 'Title')
  String get title;
  @override
  @JsonKey(name: 'Year')
  String get year;
  @override
  @JsonKey(name: 'Plot')
  String get plot;
  @override
  @JsonKey(name: 'Poster')
  String get poster;
  @override
  @JsonKey(name: 'imdbRating')
  String get imdbRating;
  @override
  @JsonKey(name: 'Rated')
  String? get rated;
  @override
  @JsonKey(name: 'Released')
  String? get released;
  @override
  @JsonKey(name: 'Runtime')
  String? get runtime;
  @override
  @JsonKey(name: 'Genre')
  String? get genre;
  @override
  @JsonKey(name: 'Director')
  String? get director;
  @override
  @JsonKey(name: 'Writer')
  String? get writer;
  @override
  @JsonKey(name: 'Actors')
  String? get actors;
  @override
  @JsonKey(name: 'Language')
  String? get language;
  @override
  @JsonKey(name: 'Country')
  String? get country;
  @override
  @JsonKey(name: 'Awards')
  String? get awards;
  @override
  @JsonKey(name: 'Metascore')
  String? get metascore;
  @override
  @JsonKey(name: 'imdbVotes')
  String? get imdbVotes;
  @override
  @JsonKey(name: 'imdbID')
  String get imdbID;
  @override
  @JsonKey(name: 'Images')
  List<String>? get images;

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieImplCopyWith<_$MovieImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
