// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProductState {
  List<ProductModel> get products => throw _privateConstructorUsedError;
  List<ProductModel> get filteredProducts => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductStateCopyWith<ProductState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductStateCopyWith<$Res> {
  factory $ProductStateCopyWith(
    ProductState value,
    $Res Function(ProductState) then,
  ) = _$ProductStateCopyWithImpl<$Res, ProductState>;
  @useResult
  $Res call({
    List<ProductModel> products,
    List<ProductModel> filteredProducts,
    String query,
    bool isLoading,
  });
}

/// @nodoc
class _$ProductStateCopyWithImpl<$Res, $Val extends ProductState>
    implements $ProductStateCopyWith<$Res> {
  _$ProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? filteredProducts = null,
    Object? query = null,
    Object? isLoading = null,
  }) {
    return _then(
      _value.copyWith(
            products: null == products
                ? _value.products
                : products // ignore: cast_nullable_to_non_nullable
                      as List<ProductModel>,
            filteredProducts: null == filteredProducts
                ? _value.filteredProducts
                : filteredProducts // ignore: cast_nullable_to_non_nullable
                      as List<ProductModel>,
            query: null == query
                ? _value.query
                : query // ignore: cast_nullable_to_non_nullable
                      as String,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductStateImplCopyWith<$Res>
    implements $ProductStateCopyWith<$Res> {
  factory _$$ProductStateImplCopyWith(
    _$ProductStateImpl value,
    $Res Function(_$ProductStateImpl) then,
  ) = __$$ProductStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ProductModel> products,
    List<ProductModel> filteredProducts,
    String query,
    bool isLoading,
  });
}

/// @nodoc
class __$$ProductStateImplCopyWithImpl<$Res>
    extends _$ProductStateCopyWithImpl<$Res, _$ProductStateImpl>
    implements _$$ProductStateImplCopyWith<$Res> {
  __$$ProductStateImplCopyWithImpl(
    _$ProductStateImpl _value,
    $Res Function(_$ProductStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? filteredProducts = null,
    Object? query = null,
    Object? isLoading = null,
  }) {
    return _then(
      _$ProductStateImpl(
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<ProductModel>,
        filteredProducts: null == filteredProducts
            ? _value._filteredProducts
            : filteredProducts // ignore: cast_nullable_to_non_nullable
                  as List<ProductModel>,
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ProductStateImpl implements _ProductState {
  const _$ProductStateImpl({
    final List<ProductModel> products = const [],
    final List<ProductModel> filteredProducts = const [],
    this.query = '',
    this.isLoading = false,
  }) : _products = products,
       _filteredProducts = filteredProducts;

  final List<ProductModel> _products;
  @override
  @JsonKey()
  List<ProductModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<ProductModel> _filteredProducts;
  @override
  @JsonKey()
  List<ProductModel> get filteredProducts {
    if (_filteredProducts is EqualUnmodifiableListView)
      return _filteredProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredProducts);
  }

  @override
  @JsonKey()
  final String query;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ProductState(products: $products, filteredProducts: $filteredProducts, query: $query, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductStateImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(
              other._filteredProducts,
              _filteredProducts,
            ) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_products),
    const DeepCollectionEquality().hash(_filteredProducts),
    query,
    isLoading,
  );

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductStateImplCopyWith<_$ProductStateImpl> get copyWith =>
      __$$ProductStateImplCopyWithImpl<_$ProductStateImpl>(this, _$identity);
}

abstract class _ProductState implements ProductState {
  const factory _ProductState({
    final List<ProductModel> products,
    final List<ProductModel> filteredProducts,
    final String query,
    final bool isLoading,
  }) = _$ProductStateImpl;

  @override
  List<ProductModel> get products;
  @override
  List<ProductModel> get filteredProducts;
  @override
  String get query;
  @override
  bool get isLoading;

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductStateImplCopyWith<_$ProductStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
