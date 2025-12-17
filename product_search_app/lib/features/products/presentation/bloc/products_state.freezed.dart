// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductsState {
  ProductsStatus get status => throw _privateConstructorUsedError;
  List<Product> get products => throw _privateConstructorUsedError;
  List<Product> get filtered => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductsStateCopyWith<ProductsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsStateCopyWith<$Res> {
  factory $ProductsStateCopyWith(
          ProductsState value, $Res Function(ProductsState) then) =
      _$ProductsStateCopyWithImpl<$Res, ProductsState>;
  @useResult
  $Res call(
      {ProductsStatus status,
      List<Product> products,
      List<Product> filtered,
      String query,
      String? errorMessage});
}

/// @nodoc
class _$ProductsStateCopyWithImpl<$Res, $Val extends ProductsState>
    implements $ProductsStateCopyWith<$Res> {
  _$ProductsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? products = null,
    Object? filtered = null,
    Object? query = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProductsStatus,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      filtered: null == filtered
          ? _value.filtered
          : filtered // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductsStateImplCopyWith<$Res>
    implements $ProductsStateCopyWith<$Res> {
  factory _$$ProductsStateImplCopyWith(
          _$ProductsStateImpl value, $Res Function(_$ProductsStateImpl) then) =
      __$$ProductsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProductsStatus status,
      List<Product> products,
      List<Product> filtered,
      String query,
      String? errorMessage});
}

/// @nodoc
class __$$ProductsStateImplCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res, _$ProductsStateImpl>
    implements _$$ProductsStateImplCopyWith<$Res> {
  __$$ProductsStateImplCopyWithImpl(
      _$ProductsStateImpl _value, $Res Function(_$ProductsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? products = null,
    Object? filtered = null,
    Object? query = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ProductsStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProductsStatus,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      filtered: null == filtered
          ? _value._filtered
          : filtered // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ProductsStateImpl implements _ProductsState {
  const _$ProductsStateImpl(
      {this.status = ProductsStatus.initial,
      final List<Product> products = const <Product>[],
      final List<Product> filtered = const <Product>[],
      this.query = '',
      this.errorMessage})
      : _products = products,
        _filtered = filtered;

  @override
  @JsonKey()
  final ProductsStatus status;
  final List<Product> _products;
  @override
  @JsonKey()
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<Product> _filtered;
  @override
  @JsonKey()
  List<Product> get filtered {
    if (_filtered is EqualUnmodifiableListView) return _filtered;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filtered);
  }

  @override
  @JsonKey()
  final String query;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ProductsState(status: $status, products: $products, filtered: $filtered, query: $query, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(other._filtered, _filtered) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_filtered),
      query,
      errorMessage);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductsStateImplCopyWith<_$ProductsStateImpl> get copyWith =>
      __$$ProductsStateImplCopyWithImpl<_$ProductsStateImpl>(this, _$identity);
}

abstract class _ProductsState implements ProductsState {
  const factory _ProductsState(
      {final ProductsStatus status,
      final List<Product> products,
      final List<Product> filtered,
      final String query,
      final String? errorMessage}) = _$ProductsStateImpl;

  @override
  ProductsStatus get status;
  @override
  List<Product> get products;
  @override
  List<Product> get filtered;
  @override
  String get query;
  @override
  String? get errorMessage;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductsStateImplCopyWith<_$ProductsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
