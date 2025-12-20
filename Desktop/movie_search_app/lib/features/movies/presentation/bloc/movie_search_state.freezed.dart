// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MovieSearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Movie> movies) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Movie> movies)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Movie> movies)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MovieSearchInitial value) initial,
    required TResult Function(MovieSearchLoading value) loading,
    required TResult Function(MovieSearchLoaded value) loaded,
    required TResult Function(MovieSearchError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MovieSearchInitial value)? initial,
    TResult? Function(MovieSearchLoading value)? loading,
    TResult? Function(MovieSearchLoaded value)? loaded,
    TResult? Function(MovieSearchError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MovieSearchInitial value)? initial,
    TResult Function(MovieSearchLoading value)? loading,
    TResult Function(MovieSearchLoaded value)? loaded,
    TResult Function(MovieSearchError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieSearchStateCopyWith<$Res> {
  factory $MovieSearchStateCopyWith(
          MovieSearchState value, $Res Function(MovieSearchState) then) =
      _$MovieSearchStateCopyWithImpl<$Res, MovieSearchState>;
}

/// @nodoc
class _$MovieSearchStateCopyWithImpl<$Res, $Val extends MovieSearchState>
    implements $MovieSearchStateCopyWith<$Res> {
  _$MovieSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MovieSearchInitialImplCopyWith<$Res> {
  factory _$$MovieSearchInitialImplCopyWith(_$MovieSearchInitialImpl value,
          $Res Function(_$MovieSearchInitialImpl) then) =
      __$$MovieSearchInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MovieSearchInitialImplCopyWithImpl<$Res>
    extends _$MovieSearchStateCopyWithImpl<$Res, _$MovieSearchInitialImpl>
    implements _$$MovieSearchInitialImplCopyWith<$Res> {
  __$$MovieSearchInitialImplCopyWithImpl(_$MovieSearchInitialImpl _value,
      $Res Function(_$MovieSearchInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MovieSearchInitialImpl implements MovieSearchInitial {
  const _$MovieSearchInitialImpl();

  @override
  String toString() {
    return 'MovieSearchState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MovieSearchInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Movie> movies) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Movie> movies)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Movie> movies)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MovieSearchInitial value) initial,
    required TResult Function(MovieSearchLoading value) loading,
    required TResult Function(MovieSearchLoaded value) loaded,
    required TResult Function(MovieSearchError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MovieSearchInitial value)? initial,
    TResult? Function(MovieSearchLoading value)? loading,
    TResult? Function(MovieSearchLoaded value)? loaded,
    TResult? Function(MovieSearchError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MovieSearchInitial value)? initial,
    TResult Function(MovieSearchLoading value)? loading,
    TResult Function(MovieSearchLoaded value)? loaded,
    TResult Function(MovieSearchError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MovieSearchInitial implements MovieSearchState {
  const factory MovieSearchInitial() = _$MovieSearchInitialImpl;
}

/// @nodoc
abstract class _$$MovieSearchLoadingImplCopyWith<$Res> {
  factory _$$MovieSearchLoadingImplCopyWith(_$MovieSearchLoadingImpl value,
          $Res Function(_$MovieSearchLoadingImpl) then) =
      __$$MovieSearchLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MovieSearchLoadingImplCopyWithImpl<$Res>
    extends _$MovieSearchStateCopyWithImpl<$Res, _$MovieSearchLoadingImpl>
    implements _$$MovieSearchLoadingImplCopyWith<$Res> {
  __$$MovieSearchLoadingImplCopyWithImpl(_$MovieSearchLoadingImpl _value,
      $Res Function(_$MovieSearchLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MovieSearchLoadingImpl implements MovieSearchLoading {
  const _$MovieSearchLoadingImpl();

  @override
  String toString() {
    return 'MovieSearchState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MovieSearchLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Movie> movies) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Movie> movies)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Movie> movies)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MovieSearchInitial value) initial,
    required TResult Function(MovieSearchLoading value) loading,
    required TResult Function(MovieSearchLoaded value) loaded,
    required TResult Function(MovieSearchError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MovieSearchInitial value)? initial,
    TResult? Function(MovieSearchLoading value)? loading,
    TResult? Function(MovieSearchLoaded value)? loaded,
    TResult? Function(MovieSearchError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MovieSearchInitial value)? initial,
    TResult Function(MovieSearchLoading value)? loading,
    TResult Function(MovieSearchLoaded value)? loaded,
    TResult Function(MovieSearchError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MovieSearchLoading implements MovieSearchState {
  const factory MovieSearchLoading() = _$MovieSearchLoadingImpl;
}

/// @nodoc
abstract class _$$MovieSearchLoadedImplCopyWith<$Res> {
  factory _$$MovieSearchLoadedImplCopyWith(_$MovieSearchLoadedImpl value,
          $Res Function(_$MovieSearchLoadedImpl) then) =
      __$$MovieSearchLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Movie> movies});
}

/// @nodoc
class __$$MovieSearchLoadedImplCopyWithImpl<$Res>
    extends _$MovieSearchStateCopyWithImpl<$Res, _$MovieSearchLoadedImpl>
    implements _$$MovieSearchLoadedImplCopyWith<$Res> {
  __$$MovieSearchLoadedImplCopyWithImpl(_$MovieSearchLoadedImpl _value,
      $Res Function(_$MovieSearchLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movies = null,
  }) {
    return _then(_$MovieSearchLoadedImpl(
      null == movies
          ? _value._movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
    ));
  }
}

/// @nodoc

class _$MovieSearchLoadedImpl implements MovieSearchLoaded {
  const _$MovieSearchLoadedImpl(final List<Movie> movies) : _movies = movies;

  final List<Movie> _movies;
  @override
  List<Movie> get movies {
    if (_movies is EqualUnmodifiableListView) return _movies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movies);
  }

  @override
  String toString() {
    return 'MovieSearchState.loaded(movies: $movies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieSearchLoadedImpl &&
            const DeepCollectionEquality().equals(other._movies, _movies));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_movies));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieSearchLoadedImplCopyWith<_$MovieSearchLoadedImpl> get copyWith =>
      __$$MovieSearchLoadedImplCopyWithImpl<_$MovieSearchLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Movie> movies) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(movies);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Movie> movies)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(movies);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Movie> movies)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(movies);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MovieSearchInitial value) initial,
    required TResult Function(MovieSearchLoading value) loading,
    required TResult Function(MovieSearchLoaded value) loaded,
    required TResult Function(MovieSearchError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MovieSearchInitial value)? initial,
    TResult? Function(MovieSearchLoading value)? loading,
    TResult? Function(MovieSearchLoaded value)? loaded,
    TResult? Function(MovieSearchError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MovieSearchInitial value)? initial,
    TResult Function(MovieSearchLoading value)? loading,
    TResult Function(MovieSearchLoaded value)? loaded,
    TResult Function(MovieSearchError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class MovieSearchLoaded implements MovieSearchState {
  const factory MovieSearchLoaded(final List<Movie> movies) =
      _$MovieSearchLoadedImpl;

  List<Movie> get movies;
  @JsonKey(ignore: true)
  _$$MovieSearchLoadedImplCopyWith<_$MovieSearchLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MovieSearchErrorImplCopyWith<$Res> {
  factory _$$MovieSearchErrorImplCopyWith(_$MovieSearchErrorImpl value,
          $Res Function(_$MovieSearchErrorImpl) then) =
      __$$MovieSearchErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MovieSearchErrorImplCopyWithImpl<$Res>
    extends _$MovieSearchStateCopyWithImpl<$Res, _$MovieSearchErrorImpl>
    implements _$$MovieSearchErrorImplCopyWith<$Res> {
  __$$MovieSearchErrorImplCopyWithImpl(_$MovieSearchErrorImpl _value,
      $Res Function(_$MovieSearchErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MovieSearchErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MovieSearchErrorImpl implements MovieSearchError {
  const _$MovieSearchErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'MovieSearchState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieSearchErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieSearchErrorImplCopyWith<_$MovieSearchErrorImpl> get copyWith =>
      __$$MovieSearchErrorImplCopyWithImpl<_$MovieSearchErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Movie> movies) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Movie> movies)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Movie> movies)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MovieSearchInitial value) initial,
    required TResult Function(MovieSearchLoading value) loading,
    required TResult Function(MovieSearchLoaded value) loaded,
    required TResult Function(MovieSearchError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MovieSearchInitial value)? initial,
    TResult? Function(MovieSearchLoading value)? loading,
    TResult? Function(MovieSearchLoaded value)? loaded,
    TResult? Function(MovieSearchError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MovieSearchInitial value)? initial,
    TResult Function(MovieSearchLoading value)? loading,
    TResult Function(MovieSearchLoaded value)? loaded,
    TResult Function(MovieSearchError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MovieSearchError implements MovieSearchState {
  const factory MovieSearchError(final String message) = _$MovieSearchErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$MovieSearchErrorImplCopyWith<_$MovieSearchErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
