// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StudentEvent {
  String? get query => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? query) loadStudents,
    required TResult Function(String query) searchStudents,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? query)? loadStudents,
    TResult? Function(String query)? searchStudents,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? query)? loadStudents,
    TResult Function(String query)? searchStudents,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStudents value) loadStudents,
    required TResult Function(_SearchStudents value) searchStudents,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStudents value)? loadStudents,
    TResult? Function(_SearchStudents value)? searchStudents,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStudents value)? loadStudents,
    TResult Function(_SearchStudents value)? searchStudents,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentEventCopyWith<StudentEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentEventCopyWith<$Res> {
  factory $StudentEventCopyWith(
          StudentEvent value, $Res Function(StudentEvent) then) =
      _$StudentEventCopyWithImpl<$Res, StudentEvent>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class _$StudentEventCopyWithImpl<$Res, $Val extends StudentEvent>
    implements $StudentEventCopyWith<$Res> {
  _$StudentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_value.copyWith(
      query: null == query
          ? _value.query!
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadStudentsImplCopyWith<$Res>
    implements $StudentEventCopyWith<$Res> {
  factory _$$LoadStudentsImplCopyWith(
          _$LoadStudentsImpl value, $Res Function(_$LoadStudentsImpl) then) =
      __$$LoadStudentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? query});
}

/// @nodoc
class __$$LoadStudentsImplCopyWithImpl<$Res>
    extends _$StudentEventCopyWithImpl<$Res, _$LoadStudentsImpl>
    implements _$$LoadStudentsImplCopyWith<$Res> {
  __$$LoadStudentsImplCopyWithImpl(
      _$LoadStudentsImpl _value, $Res Function(_$LoadStudentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = freezed,
  }) {
    return _then(_$LoadStudentsImpl(
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadStudentsImpl implements _LoadStudents {
  const _$LoadStudentsImpl({this.query});

  @override
  final String? query;

  @override
  String toString() {
    return 'StudentEvent.loadStudents(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadStudentsImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadStudentsImplCopyWith<_$LoadStudentsImpl> get copyWith =>
      __$$LoadStudentsImplCopyWithImpl<_$LoadStudentsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? query) loadStudents,
    required TResult Function(String query) searchStudents,
  }) {
    return loadStudents(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? query)? loadStudents,
    TResult? Function(String query)? searchStudents,
  }) {
    return loadStudents?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? query)? loadStudents,
    TResult Function(String query)? searchStudents,
    required TResult orElse(),
  }) {
    if (loadStudents != null) {
      return loadStudents(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStudents value) loadStudents,
    required TResult Function(_SearchStudents value) searchStudents,
  }) {
    return loadStudents(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStudents value)? loadStudents,
    TResult? Function(_SearchStudents value)? searchStudents,
  }) {
    return loadStudents?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStudents value)? loadStudents,
    TResult Function(_SearchStudents value)? searchStudents,
    required TResult orElse(),
  }) {
    if (loadStudents != null) {
      return loadStudents(this);
    }
    return orElse();
  }
}

abstract class _LoadStudents implements StudentEvent {
  const factory _LoadStudents({final String? query}) = _$LoadStudentsImpl;

  @override
  String? get query;

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadStudentsImplCopyWith<_$LoadStudentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchStudentsImplCopyWith<$Res>
    implements $StudentEventCopyWith<$Res> {
  factory _$$SearchStudentsImplCopyWith(_$SearchStudentsImpl value,
          $Res Function(_$SearchStudentsImpl) then) =
      __$$SearchStudentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchStudentsImplCopyWithImpl<$Res>
    extends _$StudentEventCopyWithImpl<$Res, _$SearchStudentsImpl>
    implements _$$SearchStudentsImplCopyWith<$Res> {
  __$$SearchStudentsImplCopyWithImpl(
      _$SearchStudentsImpl _value, $Res Function(_$SearchStudentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$SearchStudentsImpl(
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchStudentsImpl implements _SearchStudents {
  const _$SearchStudentsImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'StudentEvent.searchStudents(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStudentsImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStudentsImplCopyWith<_$SearchStudentsImpl> get copyWith =>
      __$$SearchStudentsImplCopyWithImpl<_$SearchStudentsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? query) loadStudents,
    required TResult Function(String query) searchStudents,
  }) {
    return searchStudents(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? query)? loadStudents,
    TResult? Function(String query)? searchStudents,
  }) {
    return searchStudents?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? query)? loadStudents,
    TResult Function(String query)? searchStudents,
    required TResult orElse(),
  }) {
    if (searchStudents != null) {
      return searchStudents(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStudents value) loadStudents,
    required TResult Function(_SearchStudents value) searchStudents,
  }) {
    return searchStudents(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStudents value)? loadStudents,
    TResult? Function(_SearchStudents value)? searchStudents,
  }) {
    return searchStudents?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStudents value)? loadStudents,
    TResult Function(_SearchStudents value)? searchStudents,
    required TResult orElse(),
  }) {
    if (searchStudents != null) {
      return searchStudents(this);
    }
    return orElse();
  }
}

abstract class _SearchStudents implements StudentEvent {
  const factory _SearchStudents(final String query) = _$SearchStudentsImpl;

  @override
  String get query;

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchStudentsImplCopyWith<_$SearchStudentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
