// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProductsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchProducts,
    required TResult Function(int id) fetchProduct,
    required TResult Function(String query) searchProducts,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchProducts,
    TResult? Function(int id)? fetchProduct,
    TResult? Function(String query)? searchProducts,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchProducts,
    TResult Function(int id)? fetchProduct,
    TResult Function(String query)? searchProducts,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchProducts value) fetchProducts,
    required TResult Function(_FetchProduct value) fetchProduct,
    required TResult Function(_SearchProducts value) searchProducts,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchProducts value)? fetchProducts,
    TResult? Function(_FetchProduct value)? fetchProduct,
    TResult? Function(_SearchProducts value)? searchProducts,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchProducts value)? fetchProducts,
    TResult Function(_FetchProduct value)? fetchProduct,
    TResult Function(_SearchProducts value)? searchProducts,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsEventCopyWith<$Res> {
  factory $ProductsEventCopyWith(
    ProductsEvent value,
    $Res Function(ProductsEvent) then,
  ) = _$ProductsEventCopyWithImpl<$Res, ProductsEvent>;
}

/// @nodoc
class _$ProductsEventCopyWithImpl<$Res, $Val extends ProductsEvent>
    implements $ProductsEventCopyWith<$Res> {
  _$ProductsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchProductsImplCopyWith<$Res> {
  factory _$$FetchProductsImplCopyWith(
    _$FetchProductsImpl value,
    $Res Function(_$FetchProductsImpl) then,
  ) = __$$FetchProductsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FetchProductsImplCopyWithImpl<$Res>
    extends _$ProductsEventCopyWithImpl<$Res, _$FetchProductsImpl>
    implements _$$FetchProductsImplCopyWith<$Res> {
  __$$FetchProductsImplCopyWithImpl(
    _$FetchProductsImpl _value,
    $Res Function(_$FetchProductsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FetchProductsImpl implements _FetchProducts {
  const _$FetchProductsImpl();

  @override
  String toString() {
    return 'ProductsEvent.fetchProducts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FetchProductsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchProducts,
    required TResult Function(int id) fetchProduct,
    required TResult Function(String query) searchProducts,
  }) {
    return fetchProducts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchProducts,
    TResult? Function(int id)? fetchProduct,
    TResult? Function(String query)? searchProducts,
  }) {
    return fetchProducts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchProducts,
    TResult Function(int id)? fetchProduct,
    TResult Function(String query)? searchProducts,
    required TResult orElse(),
  }) {
    if (fetchProducts != null) {
      return fetchProducts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchProducts value) fetchProducts,
    required TResult Function(_FetchProduct value) fetchProduct,
    required TResult Function(_SearchProducts value) searchProducts,
  }) {
    return fetchProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchProducts value)? fetchProducts,
    TResult? Function(_FetchProduct value)? fetchProduct,
    TResult? Function(_SearchProducts value)? searchProducts,
  }) {
    return fetchProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchProducts value)? fetchProducts,
    TResult Function(_FetchProduct value)? fetchProduct,
    TResult Function(_SearchProducts value)? searchProducts,
    required TResult orElse(),
  }) {
    if (fetchProducts != null) {
      return fetchProducts(this);
    }
    return orElse();
  }
}

abstract class _FetchProducts implements ProductsEvent {
  const factory _FetchProducts() = _$FetchProductsImpl;
}

/// @nodoc
abstract class _$$FetchProductImplCopyWith<$Res> {
  factory _$$FetchProductImplCopyWith(
    _$FetchProductImpl value,
    $Res Function(_$FetchProductImpl) then,
  ) = __$$FetchProductImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$FetchProductImplCopyWithImpl<$Res>
    extends _$ProductsEventCopyWithImpl<$Res, _$FetchProductImpl>
    implements _$$FetchProductImplCopyWith<$Res> {
  __$$FetchProductImplCopyWithImpl(
    _$FetchProductImpl _value,
    $Res Function(_$FetchProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$FetchProductImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$FetchProductImpl implements _FetchProduct {
  const _$FetchProductImpl(this.id);

  @override
  final int id;

  @override
  String toString() {
    return 'ProductsEvent.fetchProduct(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchProductImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of ProductsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchProductImplCopyWith<_$FetchProductImpl> get copyWith =>
      __$$FetchProductImplCopyWithImpl<_$FetchProductImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchProducts,
    required TResult Function(int id) fetchProduct,
    required TResult Function(String query) searchProducts,
  }) {
    return fetchProduct(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchProducts,
    TResult? Function(int id)? fetchProduct,
    TResult? Function(String query)? searchProducts,
  }) {
    return fetchProduct?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchProducts,
    TResult Function(int id)? fetchProduct,
    TResult Function(String query)? searchProducts,
    required TResult orElse(),
  }) {
    if (fetchProduct != null) {
      return fetchProduct(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchProducts value) fetchProducts,
    required TResult Function(_FetchProduct value) fetchProduct,
    required TResult Function(_SearchProducts value) searchProducts,
  }) {
    return fetchProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchProducts value)? fetchProducts,
    TResult? Function(_FetchProduct value)? fetchProduct,
    TResult? Function(_SearchProducts value)? searchProducts,
  }) {
    return fetchProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchProducts value)? fetchProducts,
    TResult Function(_FetchProduct value)? fetchProduct,
    TResult Function(_SearchProducts value)? searchProducts,
    required TResult orElse(),
  }) {
    if (fetchProduct != null) {
      return fetchProduct(this);
    }
    return orElse();
  }
}

abstract class _FetchProduct implements ProductsEvent {
  const factory _FetchProduct(final int id) = _$FetchProductImpl;

  int get id;

  /// Create a copy of ProductsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchProductImplCopyWith<_$FetchProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchProductsImplCopyWith<$Res> {
  factory _$$SearchProductsImplCopyWith(
    _$SearchProductsImpl value,
    $Res Function(_$SearchProductsImpl) then,
  ) = __$$SearchProductsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchProductsImplCopyWithImpl<$Res>
    extends _$ProductsEventCopyWithImpl<$Res, _$SearchProductsImpl>
    implements _$$SearchProductsImplCopyWith<$Res> {
  __$$SearchProductsImplCopyWithImpl(
    _$SearchProductsImpl _value,
    $Res Function(_$SearchProductsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$SearchProductsImpl(
        null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchProductsImpl implements _SearchProducts {
  const _$SearchProductsImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'ProductsEvent.searchProducts(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchProductsImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of ProductsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchProductsImplCopyWith<_$SearchProductsImpl> get copyWith =>
      __$$SearchProductsImplCopyWithImpl<_$SearchProductsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchProducts,
    required TResult Function(int id) fetchProduct,
    required TResult Function(String query) searchProducts,
  }) {
    return searchProducts(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchProducts,
    TResult? Function(int id)? fetchProduct,
    TResult? Function(String query)? searchProducts,
  }) {
    return searchProducts?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchProducts,
    TResult Function(int id)? fetchProduct,
    TResult Function(String query)? searchProducts,
    required TResult orElse(),
  }) {
    if (searchProducts != null) {
      return searchProducts(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchProducts value) fetchProducts,
    required TResult Function(_FetchProduct value) fetchProduct,
    required TResult Function(_SearchProducts value) searchProducts,
  }) {
    return searchProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchProducts value)? fetchProducts,
    TResult? Function(_FetchProduct value)? fetchProduct,
    TResult? Function(_SearchProducts value)? searchProducts,
  }) {
    return searchProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchProducts value)? fetchProducts,
    TResult Function(_FetchProduct value)? fetchProduct,
    TResult Function(_SearchProducts value)? searchProducts,
    required TResult orElse(),
  }) {
    if (searchProducts != null) {
      return searchProducts(this);
    }
    return orElse();
  }
}

abstract class _SearchProducts implements ProductsEvent {
  const factory _SearchProducts(final String query) = _$SearchProductsImpl;

  String get query;

  /// Create a copy of ProductsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchProductsImplCopyWith<_$SearchProductsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProductsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<Product> products) loading,
    required TResult Function(List<Product> products) loadSuccess,
    required TResult Function(Product product) detailSuccess,
    required TResult Function(List<Product> products, String query)
    searchSuccess,
    required TResult Function(String message) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Product> products)? loading,
    TResult? Function(List<Product> products)? loadSuccess,
    TResult? Function(Product product)? detailSuccess,
    TResult? Function(List<Product> products, String query)? searchSuccess,
    TResult? Function(String message)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Product> products)? loading,
    TResult Function(List<Product> products)? loadSuccess,
    TResult Function(Product product)? detailSuccess,
    TResult Function(List<Product> products, String query)? searchSuccess,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_Failure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_Failure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsStateCopyWith<$Res> {
  factory $ProductsStateCopyWith(
    ProductsState value,
    $Res Function(ProductsState) then,
  ) = _$ProductsStateCopyWithImpl<$Res, ProductsState>;
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
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ProductsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<Product> products) loading,
    required TResult Function(List<Product> products) loadSuccess,
    required TResult Function(Product product) detailSuccess,
    required TResult Function(List<Product> products, String query)
    searchSuccess,
    required TResult Function(String message) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Product> products)? loading,
    TResult? Function(List<Product> products)? loadSuccess,
    TResult? Function(Product product)? detailSuccess,
    TResult? Function(List<Product> products, String query)? searchSuccess,
    TResult? Function(String message)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Product> products)? loading,
    TResult Function(List<Product> products)? loadSuccess,
    TResult Function(Product product)? detailSuccess,
    TResult Function(List<Product> products, String query)? searchSuccess,
    TResult Function(String message)? failure,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_Failure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_Failure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ProductsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Product> products});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? products = null}) {
    return _then(
      _$LoadingImpl(
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<Product>,
      ),
    );
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl({final List<Product> products = const []})
    : _products = products;

  final List<Product> _products;
  @override
  @JsonKey()
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'ProductsState.loading(products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_products));

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<Product> products) loading,
    required TResult Function(List<Product> products) loadSuccess,
    required TResult Function(Product product) detailSuccess,
    required TResult Function(List<Product> products, String query)
    searchSuccess,
    required TResult Function(String message) failure,
  }) {
    return loading(products);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Product> products)? loading,
    TResult? Function(List<Product> products)? loadSuccess,
    TResult? Function(Product product)? detailSuccess,
    TResult? Function(List<Product> products, String query)? searchSuccess,
    TResult? Function(String message)? failure,
  }) {
    return loading?.call(products);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Product> products)? loading,
    TResult Function(List<Product> products)? loadSuccess,
    TResult Function(Product product)? detailSuccess,
    TResult Function(List<Product> products, String query)? searchSuccess,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(products);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_Failure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_Failure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ProductsState {
  const factory _Loading({final List<Product> products}) = _$LoadingImpl;

  List<Product> get products;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadSuccessImplCopyWith<$Res> {
  factory _$$LoadSuccessImplCopyWith(
    _$LoadSuccessImpl value,
    $Res Function(_$LoadSuccessImpl) then,
  ) = __$$LoadSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Product> products});
}

/// @nodoc
class __$$LoadSuccessImplCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res, _$LoadSuccessImpl>
    implements _$$LoadSuccessImplCopyWith<$Res> {
  __$$LoadSuccessImplCopyWithImpl(
    _$LoadSuccessImpl _value,
    $Res Function(_$LoadSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? products = null}) {
    return _then(
      _$LoadSuccessImpl(
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<Product>,
      ),
    );
  }
}

/// @nodoc

class _$LoadSuccessImpl implements _LoadSuccess {
  const _$LoadSuccessImpl({required final List<Product> products})
    : _products = products;

  final List<Product> _products;
  @override
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'ProductsState.loadSuccess(products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSuccessImpl &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_products));

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadSuccessImplCopyWith<_$LoadSuccessImpl> get copyWith =>
      __$$LoadSuccessImplCopyWithImpl<_$LoadSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<Product> products) loading,
    required TResult Function(List<Product> products) loadSuccess,
    required TResult Function(Product product) detailSuccess,
    required TResult Function(List<Product> products, String query)
    searchSuccess,
    required TResult Function(String message) failure,
  }) {
    return loadSuccess(products);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Product> products)? loading,
    TResult? Function(List<Product> products)? loadSuccess,
    TResult? Function(Product product)? detailSuccess,
    TResult? Function(List<Product> products, String query)? searchSuccess,
    TResult? Function(String message)? failure,
  }) {
    return loadSuccess?.call(products);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Product> products)? loading,
    TResult Function(List<Product> products)? loadSuccess,
    TResult Function(Product product)? detailSuccess,
    TResult Function(List<Product> products, String query)? searchSuccess,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(products);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_Failure value) failure,
  }) {
    return loadSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_Failure value)? failure,
  }) {
    return loadSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(this);
    }
    return orElse();
  }
}

abstract class _LoadSuccess implements ProductsState {
  const factory _LoadSuccess({required final List<Product> products}) =
      _$LoadSuccessImpl;

  List<Product> get products;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadSuccessImplCopyWith<_$LoadSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DetailSuccessImplCopyWith<$Res> {
  factory _$$DetailSuccessImplCopyWith(
    _$DetailSuccessImpl value,
    $Res Function(_$DetailSuccessImpl) then,
  ) = __$$DetailSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Product product});
}

/// @nodoc
class __$$DetailSuccessImplCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res, _$DetailSuccessImpl>
    implements _$$DetailSuccessImplCopyWith<$Res> {
  __$$DetailSuccessImplCopyWithImpl(
    _$DetailSuccessImpl _value,
    $Res Function(_$DetailSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? product = null}) {
    return _then(
      _$DetailSuccessImpl(
        product: null == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as Product,
      ),
    );
  }
}

/// @nodoc

class _$DetailSuccessImpl implements _DetailSuccess {
  const _$DetailSuccessImpl({required this.product});

  @override
  final Product product;

  @override
  String toString() {
    return 'ProductsState.detailSuccess(product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailSuccessImpl &&
            (identical(other.product, product) || other.product == product));
  }

  @override
  int get hashCode => Object.hash(runtimeType, product);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailSuccessImplCopyWith<_$DetailSuccessImpl> get copyWith =>
      __$$DetailSuccessImplCopyWithImpl<_$DetailSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<Product> products) loading,
    required TResult Function(List<Product> products) loadSuccess,
    required TResult Function(Product product) detailSuccess,
    required TResult Function(List<Product> products, String query)
    searchSuccess,
    required TResult Function(String message) failure,
  }) {
    return detailSuccess(product);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Product> products)? loading,
    TResult? Function(List<Product> products)? loadSuccess,
    TResult? Function(Product product)? detailSuccess,
    TResult? Function(List<Product> products, String query)? searchSuccess,
    TResult? Function(String message)? failure,
  }) {
    return detailSuccess?.call(product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Product> products)? loading,
    TResult Function(List<Product> products)? loadSuccess,
    TResult Function(Product product)? detailSuccess,
    TResult Function(List<Product> products, String query)? searchSuccess,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (detailSuccess != null) {
      return detailSuccess(product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_Failure value) failure,
  }) {
    return detailSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_Failure value)? failure,
  }) {
    return detailSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (detailSuccess != null) {
      return detailSuccess(this);
    }
    return orElse();
  }
}

abstract class _DetailSuccess implements ProductsState {
  const factory _DetailSuccess({required final Product product}) =
      _$DetailSuccessImpl;

  Product get product;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetailSuccessImplCopyWith<_$DetailSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchSuccessImplCopyWith<$Res> {
  factory _$$SearchSuccessImplCopyWith(
    _$SearchSuccessImpl value,
    $Res Function(_$SearchSuccessImpl) then,
  ) = __$$SearchSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Product> products, String query});
}

/// @nodoc
class __$$SearchSuccessImplCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res, _$SearchSuccessImpl>
    implements _$$SearchSuccessImplCopyWith<$Res> {
  __$$SearchSuccessImplCopyWithImpl(
    _$SearchSuccessImpl _value,
    $Res Function(_$SearchSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? products = null, Object? query = null}) {
    return _then(
      _$SearchSuccessImpl(
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<Product>,
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchSuccessImpl implements _SearchSuccess {
  const _$SearchSuccessImpl({
    required final List<Product> products,
    required this.query,
  }) : _products = products;

  final List<Product> _products;
  @override
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  final String query;

  @override
  String toString() {
    return 'ProductsState.searchSuccess(products: $products, query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchSuccessImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_products),
    query,
  );

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchSuccessImplCopyWith<_$SearchSuccessImpl> get copyWith =>
      __$$SearchSuccessImplCopyWithImpl<_$SearchSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<Product> products) loading,
    required TResult Function(List<Product> products) loadSuccess,
    required TResult Function(Product product) detailSuccess,
    required TResult Function(List<Product> products, String query)
    searchSuccess,
    required TResult Function(String message) failure,
  }) {
    return searchSuccess(products, query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Product> products)? loading,
    TResult? Function(List<Product> products)? loadSuccess,
    TResult? Function(Product product)? detailSuccess,
    TResult? Function(List<Product> products, String query)? searchSuccess,
    TResult? Function(String message)? failure,
  }) {
    return searchSuccess?.call(products, query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Product> products)? loading,
    TResult Function(List<Product> products)? loadSuccess,
    TResult Function(Product product)? detailSuccess,
    TResult Function(List<Product> products, String query)? searchSuccess,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (searchSuccess != null) {
      return searchSuccess(products, query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_Failure value) failure,
  }) {
    return searchSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_Failure value)? failure,
  }) {
    return searchSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (searchSuccess != null) {
      return searchSuccess(this);
    }
    return orElse();
  }
}

abstract class _SearchSuccess implements ProductsState {
  const factory _SearchSuccess({
    required final List<Product> products,
    required final String query,
  }) = _$SearchSuccessImpl;

  List<Product> get products;
  String get query;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchSuccessImplCopyWith<_$SearchSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
    _$FailureImpl value,
    $Res Function(_$FailureImpl) then,
  ) = __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
    _$FailureImpl _value,
    $Res Function(_$FailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$FailureImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ProductsState.failure(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<Product> products) loading,
    required TResult Function(List<Product> products) loadSuccess,
    required TResult Function(Product product) detailSuccess,
    required TResult Function(List<Product> products, String query)
    searchSuccess,
    required TResult Function(String message) failure,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Product> products)? loading,
    TResult? Function(List<Product> products)? loadSuccess,
    TResult? Function(Product product)? detailSuccess,
    TResult? Function(List<Product> products, String query)? searchSuccess,
    TResult? Function(String message)? failure,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Product> products)? loading,
    TResult Function(List<Product> products)? loadSuccess,
    TResult Function(Product product)? detailSuccess,
    TResult Function(List<Product> products, String query)? searchSuccess,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements ProductsState {
  const factory _Failure(final String message) = _$FailureImpl;

  String get message;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
