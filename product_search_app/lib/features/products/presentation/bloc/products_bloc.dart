import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../products.dart';
import '../../domain/usecases/get_products.dart';
import 'products_event.dart';
import 'products_state.dart';



class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({required this.getProducts}) : super(const ProductsState()) {
    on<Started>(_onStarted);
    on<Refreshed>(_onRefreshed);
    on<QueryChanged>(_onQueryChanged);
  }

  final GetProducts getProducts;

  Future<void> _onStarted(Started event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ProductsStatus.loading, errorMessage: null));
    try {
      final products = await getProducts();
      emit(
        state.copyWith(
          status: ProductsStatus.success,
          products: products,
          filtered: _applyQuery(products, state.query),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRefreshed(Refreshed event, Emitter<ProductsState> emit) async {
    // same as started but keep query
    emit(state.copyWith(status: ProductsStatus.loading, errorMessage: null));
    try {
      final products = await getProducts();
      emit(
        state.copyWith(
          status: ProductsStatus.success,
          products: products,
          filtered: _applyQuery(products, state.query),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _onQueryChanged(QueryChanged event, Emitter<ProductsState> emit) {
    final q = event.query.trim();
    emit(
      state.copyWith(
        query: q,
        filtered: _applyQuery(state.products, q),
      ),
    );
  }

  List<Product> _applyQuery(List<Product> products, String query) {
  if (query.isEmpty) return List<Product>.from(products);

  final lower = query.toLowerCase();

  return products.where((p) {
    final title = p.title.toLowerCase();
    final desc = p.description.toLowerCase();
    return title.contains(lower) || desc.contains(lower);
  }).toList();
}

}
