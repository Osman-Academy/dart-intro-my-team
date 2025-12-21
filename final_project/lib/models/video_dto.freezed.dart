// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VideoDto _$VideoDtoFromJson(Map<String, dynamic> json) {
  return _VideoDto.fromJson(json);
}

/// @nodoc
mixin _$VideoDto {
  String get title => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;

  /// Serializes this VideoDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoDtoCopyWith<VideoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoDtoCopyWith<$Res> {
  factory $VideoDtoCopyWith(VideoDto value, $Res Function(VideoDto) then) =
      _$VideoDtoCopyWithImpl<$Res, VideoDto>;
  @useResult
  $Res call({String title, String author});
}

/// @nodoc
class _$VideoDtoCopyWithImpl<$Res, $Val extends VideoDto>
    implements $VideoDtoCopyWith<$Res> {
  _$VideoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? author = null}) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            author: null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VideoDtoImplCopyWith<$Res>
    implements $VideoDtoCopyWith<$Res> {
  factory _$$VideoDtoImplCopyWith(
    _$VideoDtoImpl value,
    $Res Function(_$VideoDtoImpl) then,
  ) = __$$VideoDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String author});
}

/// @nodoc
class __$$VideoDtoImplCopyWithImpl<$Res>
    extends _$VideoDtoCopyWithImpl<$Res, _$VideoDtoImpl>
    implements _$$VideoDtoImplCopyWith<$Res> {
  __$$VideoDtoImplCopyWithImpl(
    _$VideoDtoImpl _value,
    $Res Function(_$VideoDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VideoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? author = null}) {
    return _then(
      _$VideoDtoImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        author: null == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoDtoImpl implements _VideoDto {
  _$VideoDtoImpl({required this.title, required this.author});

  factory _$VideoDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoDtoImplFromJson(json);

  @override
  final String title;
  @override
  final String author;

  @override
  String toString() {
    return 'VideoDto(title: $title, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoDtoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, author);

  /// Create a copy of VideoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoDtoImplCopyWith<_$VideoDtoImpl> get copyWith =>
      __$$VideoDtoImplCopyWithImpl<_$VideoDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoDtoImplToJson(this);
  }
}

abstract class _VideoDto implements VideoDto {
  factory _VideoDto({
    required final String title,
    required final String author,
  }) = _$VideoDtoImpl;

  factory _VideoDto.fromJson(Map<String, dynamic> json) =
      _$VideoDtoImpl.fromJson;

  @override
  String get title;
  @override
  String get author;

  /// Create a copy of VideoDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoDtoImplCopyWith<_$VideoDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
