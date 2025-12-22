import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/products_repository.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository repository;

  ProductsBloc(this.repository) : super(ProductsState.initial()) {
    on<ProductsRequested>(_onRequested);
    on<ProductsSearchChanged>(_onSearchChanged);
    on<ProductsSearchCleared>(_onSearchCleared);
  }

  Future<void> _onRequested(
      ProductsRequested event,
      Emitter<ProductsState> emit,
      ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final items = await repository.getProducts();

      emit(
        state.copyWith(
          isLoading: false,
          products: items,
          filtered: items,
          query: '',
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onSearchChanged(
      ProductsSearchChanged event,
      Emitter<ProductsState> emit,
      ) {
    final raw = event.query;
    final q = raw.trim().toLowerCase();

    if (q.isEmpty) {
      emit(state.copyWith(query: '', filtered: state.products));
      return;
    }

    final filtered = state.products.where((p) {
      final title = p.title.toLowerCase();
      final desc = p.description.toLowerCase();


      if (_hasWildcards(q)) {
        return _wildcardMatch(q, title) || _wildcardMatch(q, desc);
      }


      return title.contains(q) || desc.contains(q);
    }).toList();

    emit(state.copyWith(query: raw, filtered: filtered));
  }

  void _onSearchCleared(
      ProductsSearchCleared event,
      Emitter<ProductsState> emit,
      ) {
    emit(state.copyWith(query: '', filtered: state.products));
  }

  bool _hasWildcards(String pattern) =>
      pattern.contains('*') || pattern.contains('?');

  bool _wildcardMatch(String pattern, String text) {

    final pat = '*$pattern*';

    int p = 0; // index in pattern
    int t = 0; // index in text
    int starIdx = -1;
    int match = 0;

    while (t < text.length) {
      if (p < pat.length &&
          (pat[p] == '?' || pat[p] == text[t])) {
        p++;
        t++;
      } else if (p < pat.length && pat[p] == '*') {
        starIdx = p;
        match = t;
        p++;
      } else if (starIdx != -1) {
        p = starIdx + 1;
        match++;
        t = match;
      } else {
        return false;
      }
    }

    while (p < pat.length && pat[p] == '*') {
      p++;
    }

    return p == pat.length;
  }
}
