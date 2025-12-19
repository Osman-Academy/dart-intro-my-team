// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchState {
  String get type => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String type) initial,
    required TResult Function(String type) loading,
    required TResult Function(List<User> users, String type) loadedUsers,
    required TResult Function(List<Product> products, String type)
        loadedProducts,
    required TResult Function(String message, String type) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String type)? initial,
    TResult? Function(String type)? loading,
    TResult? Function(List<User> users, String type)? loadedUsers,
    TResult? Function(List<Product> products, String type)? loadedProducts,
    TResult? Function(String message, String type)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String type)? initial,
    TResult Function(String type)? loading,
    TResult Function(List<User> users, String type)? loadedUsers,
    TResult Function(List<Product> products, String type)? loadedProducts,
    TResult Function(String message, String type)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(LoadedUsers value) loadedUsers,
    required TResult Function(LoadedProducts value) loadedProducts,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(LoadedUsers value)? loadedUsers,
    TResult? Function(LoadedProducts value)? loadedProducts,
    TResult? Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(LoadedUsers value)? loadedUsers,
    TResult Function(LoadedProducts value)? loadedProducts,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchStateCopyWith<SearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res, SearchState>;
  @useResult
  $Res call({String type});
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_$InitialImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl({this.type = 'users'});

  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'SearchState.initial(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String type) initial,
    required TResult Function(String type) loading,
    required TResult Function(List<User> users, String type) loadedUsers,
    required TResult Function(List<Product> products, String type)
        loadedProducts,
    required TResult Function(String message, String type) error,
  }) {
    return initial(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String type)? initial,
    TResult? Function(String type)? loading,
    TResult? Function(List<User> users, String type)? loadedUsers,
    TResult? Function(List<Product> products, String type)? loadedProducts,
    TResult? Function(String message, String type)? error,
  }) {
    return initial?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String type)? initial,
    TResult Function(String type)? loading,
    TResult Function(List<User> users, String type)? loadedUsers,
    TResult Function(List<Product> products, String type)? loadedProducts,
    TResult Function(String message, String type)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(LoadedUsers value) loadedUsers,
    required TResult Function(LoadedProducts value) loadedProducts,
    required TResult Function(Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(LoadedUsers value)? loadedUsers,
    TResult? Function(LoadedProducts value)? loadedProducts,
    TResult? Function(Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(LoadedUsers value)? loadedUsers,
    TResult Function(LoadedProducts value)? loadedProducts,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements SearchState {
  const factory Initial({final String type}) = _$InitialImpl;

  @override
  String get type;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_$LoadingImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements Loading {
  const _$LoadingImpl({this.type = 'users'});

  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'SearchState.loading(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String type) initial,
    required TResult Function(String type) loading,
    required TResult Function(List<User> users, String type) loadedUsers,
    required TResult Function(List<Product> products, String type)
        loadedProducts,
    required TResult Function(String message, String type) error,
  }) {
    return loading(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String type)? initial,
    TResult? Function(String type)? loading,
    TResult? Function(List<User> users, String type)? loadedUsers,
    TResult? Function(List<Product> products, String type)? loadedProducts,
    TResult? Function(String message, String type)? error,
  }) {
    return loading?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String type)? initial,
    TResult Function(String type)? loading,
    TResult Function(List<User> users, String type)? loadedUsers,
    TResult Function(List<Product> products, String type)? loadedProducts,
    TResult Function(String message, String type)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(LoadedUsers value) loadedUsers,
    required TResult Function(LoadedProducts value) loadedProducts,
    required TResult Function(Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(LoadedUsers value)? loadedUsers,
    TResult? Function(LoadedProducts value)? loadedProducts,
    TResult? Function(Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(LoadedUsers value)? loadedUsers,
    TResult Function(LoadedProducts value)? loadedProducts,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements SearchState {
  const factory Loading({final String type}) = _$LoadingImpl;

  @override
  String get type;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedUsersImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$LoadedUsersImplCopyWith(
          _$LoadedUsersImpl value, $Res Function(_$LoadedUsersImpl) then) =
      __$$LoadedUsersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<User> users, String type});
}

/// @nodoc
class __$$LoadedUsersImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$LoadedUsersImpl>
    implements _$$LoadedUsersImplCopyWith<$Res> {
  __$$LoadedUsersImplCopyWithImpl(
      _$LoadedUsersImpl _value, $Res Function(_$LoadedUsersImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? type = null,
  }) {
    return _then(_$LoadedUsersImpl(
      null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<User>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadedUsersImpl implements LoadedUsers {
  const _$LoadedUsersImpl(final List<User> users, {this.type = 'users'})
      : _users = users;

  final List<User> _users;
  @override
  List<User> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'SearchState.loadedUsers(users: $users, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedUsersImpl &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_users), type);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedUsersImplCopyWith<_$LoadedUsersImpl> get copyWith =>
      __$$LoadedUsersImplCopyWithImpl<_$LoadedUsersImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String type) initial,
    required TResult Function(String type) loading,
    required TResult Function(List<User> users, String type) loadedUsers,
    required TResult Function(List<Product> products, String type)
        loadedProducts,
    required TResult Function(String message, String type) error,
  }) {
    return loadedUsers(users, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String type)? initial,
    TResult? Function(String type)? loading,
    TResult? Function(List<User> users, String type)? loadedUsers,
    TResult? Function(List<Product> products, String type)? loadedProducts,
    TResult? Function(String message, String type)? error,
  }) {
    return loadedUsers?.call(users, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String type)? initial,
    TResult Function(String type)? loading,
    TResult Function(List<User> users, String type)? loadedUsers,
    TResult Function(List<Product> products, String type)? loadedProducts,
    TResult Function(String message, String type)? error,
    required TResult orElse(),
  }) {
    if (loadedUsers != null) {
      return loadedUsers(users, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(LoadedUsers value) loadedUsers,
    required TResult Function(LoadedProducts value) loadedProducts,
    required TResult Function(Error value) error,
  }) {
    return loadedUsers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(LoadedUsers value)? loadedUsers,
    TResult? Function(LoadedProducts value)? loadedProducts,
    TResult? Function(Error value)? error,
  }) {
    return loadedUsers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(LoadedUsers value)? loadedUsers,
    TResult Function(LoadedProducts value)? loadedProducts,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loadedUsers != null) {
      return loadedUsers(this);
    }
    return orElse();
  }
}

abstract class LoadedUsers implements SearchState {
  const factory LoadedUsers(final List<User> users, {final String type}) =
      _$LoadedUsersImpl;

  List<User> get users;
  @override
  String get type;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedUsersImplCopyWith<_$LoadedUsersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedProductsImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$LoadedProductsImplCopyWith(_$LoadedProductsImpl value,
          $Res Function(_$LoadedProductsImpl) then) =
      __$$LoadedProductsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Product> products, String type});
}

/// @nodoc
class __$$LoadedProductsImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$LoadedProductsImpl>
    implements _$$LoadedProductsImplCopyWith<$Res> {
  __$$LoadedProductsImplCopyWithImpl(
      _$LoadedProductsImpl _value, $Res Function(_$LoadedProductsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? type = null,
  }) {
    return _then(_$LoadedProductsImpl(
      null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadedProductsImpl implements LoadedProducts {
  const _$LoadedProductsImpl(final List<Product> products,
      {this.type = 'products'})
      : _products = products;

  final List<Product> _products;
  @override
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'SearchState.loadedProducts(products: $products, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedProductsImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_products), type);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedProductsImplCopyWith<_$LoadedProductsImpl> get copyWith =>
      __$$LoadedProductsImplCopyWithImpl<_$LoadedProductsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String type) initial,
    required TResult Function(String type) loading,
    required TResult Function(List<User> users, String type) loadedUsers,
    required TResult Function(List<Product> products, String type)
        loadedProducts,
    required TResult Function(String message, String type) error,
  }) {
    return loadedProducts(products, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String type)? initial,
    TResult? Function(String type)? loading,
    TResult? Function(List<User> users, String type)? loadedUsers,
    TResult? Function(List<Product> products, String type)? loadedProducts,
    TResult? Function(String message, String type)? error,
  }) {
    return loadedProducts?.call(products, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String type)? initial,
    TResult Function(String type)? loading,
    TResult Function(List<User> users, String type)? loadedUsers,
    TResult Function(List<Product> products, String type)? loadedProducts,
    TResult Function(String message, String type)? error,
    required TResult orElse(),
  }) {
    if (loadedProducts != null) {
      return loadedProducts(products, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(LoadedUsers value) loadedUsers,
    required TResult Function(LoadedProducts value) loadedProducts,
    required TResult Function(Error value) error,
  }) {
    return loadedProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(LoadedUsers value)? loadedUsers,
    TResult? Function(LoadedProducts value)? loadedProducts,
    TResult? Function(Error value)? error,
  }) {
    return loadedProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(LoadedUsers value)? loadedUsers,
    TResult Function(LoadedProducts value)? loadedProducts,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loadedProducts != null) {
      return loadedProducts(this);
    }
    return orElse();
  }
}

abstract class LoadedProducts implements SearchState {
  const factory LoadedProducts(final List<Product> products,
      {final String type}) = _$LoadedProductsImpl;

  List<Product> get products;
  @override
  String get type;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedProductsImplCopyWith<_$LoadedProductsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String type});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements Error {
  const _$ErrorImpl(this.message, {this.type = 'users'});

  @override
  final String message;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'SearchState.error(message: $message, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, type);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String type) initial,
    required TResult Function(String type) loading,
    required TResult Function(List<User> users, String type) loadedUsers,
    required TResult Function(List<Product> products, String type)
        loadedProducts,
    required TResult Function(String message, String type) error,
  }) {
    return error(message, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String type)? initial,
    TResult? Function(String type)? loading,
    TResult? Function(List<User> users, String type)? loadedUsers,
    TResult? Function(List<Product> products, String type)? loadedProducts,
    TResult? Function(String message, String type)? error,
  }) {
    return error?.call(message, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String type)? initial,
    TResult Function(String type)? loading,
    TResult Function(List<User> users, String type)? loadedUsers,
    TResult Function(List<Product> products, String type)? loadedProducts,
    TResult Function(String message, String type)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(LoadedUsers value) loadedUsers,
    required TResult Function(LoadedProducts value) loadedProducts,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(LoadedUsers value)? loadedUsers,
    TResult? Function(LoadedProducts value)? loadedProducts,
    TResult? Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(LoadedUsers value)? loadedUsers,
    TResult Function(LoadedProducts value)? loadedProducts,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements SearchState {
  const factory Error(final String message, {final String type}) = _$ErrorImpl;

  String get message;
  @override
  String get type;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
