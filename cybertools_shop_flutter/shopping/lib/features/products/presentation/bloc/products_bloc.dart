import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product.dart';
import '../../domain/usecases/get_products.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'products_bloc.freezed.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({
    required GetProducts getProducts,
    required GetProduct getProduct,
  })  : _getProducts = getProducts,
        _getProduct = getProduct,
        super(const ProductsState.initial()) {
    on<_FetchProducts>(_onFetchProducts);
    on<_FetchProduct>(_onFetchProduct);
    on<_SearchProducts>(_onSearchProducts);
  }

  final GetProducts _getProducts;
  final GetProduct _getProduct;
  List<Product> _cache = const [];

  Future<void> _onFetchProducts(
    _FetchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(const ProductsState.loading(products: []));
    final result = await _getProducts();
    emit(
      result.fold(
        (failure) => ProductsState.failure(failure.message),
        (products) {
          _cache = products;
          return ProductsState.loadSuccess(products: products);
        },
      ),
    );
  }

  Future<void> _onFetchProduct(
    _FetchProduct event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsState.loading(products: _cache));
    final result = await _getProduct(event.id);
    emit(
      result.fold(
        (failure) => ProductsState.failure(failure.message),
        (product) => ProductsState.detailSuccess(product: product),
      ),
    );
  }

  Future<void> _onSearchProducts(
    _SearchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    final query = event.query.trim().toLowerCase();
    if (_cache.isEmpty) {
      // Fetch first, then filter
      emit(const ProductsState.loading(products: []));
      final result = await _getProducts();
      await result.fold(
        (failure) async {
          emit(ProductsState.failure(failure.message));
        },
        (products) async {
          _cache = products;
          final filtered = _filterProducts(query, products);
          emit(ProductsState.searchSuccess(products: filtered, query: event.query));
        },
      );
      return;
    }

    final filtered = _filterProducts(query, _cache);
    emit(ProductsState.searchSuccess(products: filtered, query: event.query));
  }

  List<Product> _filterProducts(String query, List<Product> source) {
    if (query.isEmpty) return source;

    // Pattern search rules:
    // 1) Wildcards: "*" = any text, "?" = single char (case-insensitive)
    //    Example: "*scan*" , "wi?e*".
    // 2) Regex: if query is wrapped with /.../ it's treated as a Dart RegExp.
    //    Example: "/^nmap/".
    final matcher = _buildMatcher(query);

    return source.where((p) {
      final haystack = [
        p.title,
        p.description ?? '',
        p.category ?? '',
        p.brand ?? '',
      ].join(' | ');
      return matcher(haystack);
    }).toList(growable: false);
  }

  bool Function(String text) _buildMatcher(String rawQuery) {
    final q = rawQuery.trim();
    if (q.length >= 2 && q.startsWith('/') && q.endsWith('/')) {
      final pattern = q.substring(1, q.length - 1);
      final re = RegExp(pattern, caseSensitive: false);
      return (text) => re.hasMatch(text);
    }
    final re = _wildcardToRegExp(q);
    return (text) => re.hasMatch(text);
  }

  RegExp _wildcardToRegExp(String pattern) {
    // Escape regex-special chars, then restore wildcards.
    final escaped = RegExp.escape(pattern)
        .replaceAll(r'\*', '.*')
        .replaceAll(r'\?', '.');
    return RegExp(escaped, caseSensitive: false);
  }
}
