// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) {
  return _ProductDto.fromJson(json);
}

/// @nodoc
mixin _$ProductDto {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  num get price => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  /// Serializes this ProductDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductDtoCopyWith<ProductDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDtoCopyWith<$Res> {
  factory $ProductDtoCopyWith(
          ProductDto value, $Res Function(ProductDto) then) =
      _$ProductDtoCopyWithImpl<$Res, ProductDto>;
  @useResult
  $Res call(
      {int id,
      String title,
      num price,
      String description,
      String category,
      String image});
}

/// @nodoc
class _$ProductDtoCopyWithImpl<$Res, $Val extends ProductDto>
    implements $ProductDtoCopyWith<$Res> {
  _$ProductDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? price = null,
    Object? description = null,
    Object? category = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductDtoImplCopyWith<$Res>
    implements $ProductDtoCopyWith<$Res> {
  factory _$$ProductDtoImplCopyWith(
          _$ProductDtoImpl value, $Res Function(_$ProductDtoImpl) then) =
      __$$ProductDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      num price,
      String description,
      String category,
      String image});
}

/// @nodoc
class __$$ProductDtoImplCopyWithImpl<$Res>
    extends _$ProductDtoCopyWithImpl<$Res, _$ProductDtoImpl>
    implements _$$ProductDtoImplCopyWith<$Res> {
  __$$ProductDtoImplCopyWithImpl(
      _$ProductDtoImpl _value, $Res Function(_$ProductDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? price = null,
    Object? description = null,
    Object? category = null,
    Object? image = null,
  }) {
    return _then(_$ProductDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductDtoImpl implements _ProductDto {
  const _$ProductDtoImpl(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image});

  factory _$ProductDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final num price;
  @override
  final String description;
  @override
  final String category;
  @override
  final String image;

  @override
  String toString() {
    return 'ProductDto(id: $id, title: $title, price: $price, description: $description, category: $category, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, price, description, category, image);

  /// Create a copy of ProductDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDtoImplCopyWith<_$ProductDtoImpl> get copyWith =>
      __$$ProductDtoImplCopyWithImpl<_$ProductDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductDtoImplToJson(
      this,
    );
  }
}

abstract class _ProductDto implements ProductDto {
  const factory _ProductDto(
      {required final int id,
      required final String title,
      required final num price,
      required final String description,
      required final String category,
      required final String image}) = _$ProductDtoImpl;

  factory _ProductDto.fromJson(Map<String, dynamic> json) =
      _$ProductDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  num get price;
  @override
  String get description;
  @override
  String get category;
  @override
  String get image;

  /// Create a copy of ProductDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductDtoImplCopyWith<_$ProductDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
