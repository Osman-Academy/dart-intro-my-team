// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_search_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MovieSearchEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchMovies,
    required TResult Function() loadPopularMovies,
    required TResult Function() clearSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchMovies,
    TResult? Function()? loadPopularMovies,
    TResult? Function()? clearSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchMovies,
    TResult Function()? loadPopularMovies,
    TResult Function()? clearSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchMoviesEvent value) searchMovies,
    required TResult Function(LoadPopularMoviesEvent value) loadPopularMovies,
    required TResult Function(ClearSearchEvent value) clearSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchMoviesEvent value)? searchMovies,
    TResult? Function(LoadPopularMoviesEvent value)? loadPopularMovies,
    TResult? Function(ClearSearchEvent value)? clearSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchMoviesEvent value)? searchMovies,
    TResult Function(LoadPopularMoviesEvent value)? loadPopularMovies,
    TResult Function(ClearSearchEvent value)? clearSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieSearchEventCopyWith<$Res> {
  factory $MovieSearchEventCopyWith(
          MovieSearchEvent value, $Res Function(MovieSearchEvent) then) =
      _$MovieSearchEventCopyWithImpl<$Res, MovieSearchEvent>;
}

/// @nodoc
class _$MovieSearchEventCopyWithImpl<$Res, $Val extends MovieSearchEvent>
    implements $MovieSearchEventCopyWith<$Res> {
  _$MovieSearchEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieSearchEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SearchMoviesEventImplCopyWith<$Res> {
  factory _$$SearchMoviesEventImplCopyWith(_$SearchMoviesEventImpl value,
          $Res Function(_$SearchMoviesEventImpl) then) =
      __$$SearchMoviesEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchMoviesEventImplCopyWithImpl<$Res>
    extends _$MovieSearchEventCopyWithImpl<$Res, _$SearchMoviesEventImpl>
    implements _$$SearchMoviesEventImplCopyWith<$Res> {
  __$$SearchMoviesEventImplCopyWithImpl(_$SearchMoviesEventImpl _value,
      $Res Function(_$SearchMoviesEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of MovieSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$SearchMoviesEventImpl(
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchMoviesEventImpl implements SearchMoviesEvent {
  const _$SearchMoviesEventImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'MovieSearchEvent.searchMovies(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchMoviesEventImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of MovieSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchMoviesEventImplCopyWith<_$SearchMoviesEventImpl> get copyWith =>
      __$$SearchMoviesEventImplCopyWithImpl<_$SearchMoviesEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchMovies,
    required TResult Function() loadPopularMovies,
    required TResult Function() clearSearch,
  }) {
    return searchMovies(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchMovies,
    TResult? Function()? loadPopularMovies,
    TResult? Function()? clearSearch,
  }) {
    return searchMovies?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchMovies,
    TResult Function()? loadPopularMovies,
    TResult Function()? clearSearch,
    required TResult orElse(),
  }) {
    if (searchMovies != null) {
      return searchMovies(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchMoviesEvent value) searchMovies,
    required TResult Function(LoadPopularMoviesEvent value) loadPopularMovies,
    required TResult Function(ClearSearchEvent value) clearSearch,
  }) {
    return searchMovies(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchMoviesEvent value)? searchMovies,
    TResult? Function(LoadPopularMoviesEvent value)? loadPopularMovies,
    TResult? Function(ClearSearchEvent value)? clearSearch,
  }) {
    return searchMovies?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchMoviesEvent value)? searchMovies,
    TResult Function(LoadPopularMoviesEvent value)? loadPopularMovies,
    TResult Function(ClearSearchEvent value)? clearSearch,
    required TResult orElse(),
  }) {
    if (searchMovies != null) {
      return searchMovies(this);
    }
    return orElse();
  }
}

abstract class SearchMoviesEvent implements MovieSearchEvent {
  const factory SearchMoviesEvent(final String query) = _$SearchMoviesEventImpl;

  String get query;

  /// Create a copy of MovieSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchMoviesEventImplCopyWith<_$SearchMoviesEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadPopularMoviesEventImplCopyWith<$Res> {
  factory _$$LoadPopularMoviesEventImplCopyWith(
          _$LoadPopularMoviesEventImpl value,
          $Res Function(_$LoadPopularMoviesEventImpl) then) =
      __$$LoadPopularMoviesEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadPopularMoviesEventImplCopyWithImpl<$Res>
    extends _$MovieSearchEventCopyWithImpl<$Res, _$LoadPopularMoviesEventImpl>
    implements _$$LoadPopularMoviesEventImplCopyWith<$Res> {
  __$$LoadPopularMoviesEventImplCopyWithImpl(
      _$LoadPopularMoviesEventImpl _value,
      $Res Function(_$LoadPopularMoviesEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of MovieSearchEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadPopularMoviesEventImpl implements LoadPopularMoviesEvent {
  const _$LoadPopularMoviesEventImpl();

  @override
  String toString() {
    return 'MovieSearchEvent.loadPopularMovies()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadPopularMoviesEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchMovies,
    required TResult Function() loadPopularMovies,
    required TResult Function() clearSearch,
  }) {
    return loadPopularMovies();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchMovies,
    TResult? Function()? loadPopularMovies,
    TResult? Function()? clearSearch,
  }) {
    return loadPopularMovies?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchMovies,
    TResult Function()? loadPopularMovies,
    TResult Function()? clearSearch,
    required TResult orElse(),
  }) {
    if (loadPopularMovies != null) {
      return loadPopularMovies();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchMoviesEvent value) searchMovies,
    required TResult Function(LoadPopularMoviesEvent value) loadPopularMovies,
    required TResult Function(ClearSearchEvent value) clearSearch,
  }) {
    return loadPopularMovies(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchMoviesEvent value)? searchMovies,
    TResult? Function(LoadPopularMoviesEvent value)? loadPopularMovies,
    TResult? Function(ClearSearchEvent value)? clearSearch,
  }) {
    return loadPopularMovies?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchMoviesEvent value)? searchMovies,
    TResult Function(LoadPopularMoviesEvent value)? loadPopularMovies,
    TResult Function(ClearSearchEvent value)? clearSearch,
    required TResult orElse(),
  }) {
    if (loadPopularMovies != null) {
      return loadPopularMovies(this);
    }
    return orElse();
  }
}

abstract class LoadPopularMoviesEvent implements MovieSearchEvent {
  const factory LoadPopularMoviesEvent() = _$LoadPopularMoviesEventImpl;
}

/// @nodoc
abstract class _$$ClearSearchEventImplCopyWith<$Res> {
  factory _$$ClearSearchEventImplCopyWith(_$ClearSearchEventImpl value,
          $Res Function(_$ClearSearchEventImpl) then) =
      __$$ClearSearchEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSearchEventImplCopyWithImpl<$Res>
    extends _$MovieSearchEventCopyWithImpl<$Res, _$ClearSearchEventImpl>
    implements _$$ClearSearchEventImplCopyWith<$Res> {
  __$$ClearSearchEventImplCopyWithImpl(_$ClearSearchEventImpl _value,
      $Res Function(_$ClearSearchEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of MovieSearchEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSearchEventImpl implements ClearSearchEvent {
  const _$ClearSearchEventImpl();

  @override
  String toString() {
    return 'MovieSearchEvent.clearSearch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearSearchEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchMovies,
    required TResult Function() loadPopularMovies,
    required TResult Function() clearSearch,
  }) {
    return clearSearch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchMovies,
    TResult? Function()? loadPopularMovies,
    TResult? Function()? clearSearch,
  }) {
    return clearSearch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchMovies,
    TResult Function()? loadPopularMovies,
    TResult Function()? clearSearch,
    required TResult orElse(),
  }) {
    if (clearSearch != null) {
      return clearSearch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchMoviesEvent value) searchMovies,
    required TResult Function(LoadPopularMoviesEvent value) loadPopularMovies,
    required TResult Function(ClearSearchEvent value) clearSearch,
  }) {
    return clearSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchMoviesEvent value)? searchMovies,
    TResult? Function(LoadPopularMoviesEvent value)? loadPopularMovies,
    TResult? Function(ClearSearchEvent value)? clearSearch,
  }) {
    return clearSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchMoviesEvent value)? searchMovies,
    TResult Function(LoadPopularMoviesEvent value)? loadPopularMovies,
    TResult Function(ClearSearchEvent value)? clearSearch,
    required TResult orElse(),
  }) {
    if (clearSearch != null) {
      return clearSearch(this);
    }
    return orElse();
  }
}

abstract class ClearSearchEvent implements MovieSearchEvent {
  const factory ClearSearchEvent() = _$ClearSearchEventImpl;
}
