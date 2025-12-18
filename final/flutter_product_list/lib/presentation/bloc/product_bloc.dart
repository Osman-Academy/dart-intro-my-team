import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import 'package:stream_transform/stream_transform.dart'; 

part 'product_bloc.freezed.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.searchChanged(String query) = SearchChanged;
}


@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.loaded(List<Product> products) = _Loaded;
  const factory ProductState.error(String message) = _Error;
}



EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(const ProductState.initial()) {
    
    on<SearchChanged>(
      _onSearchChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onSearchChanged(SearchChanged event, Emitter<ProductState> emit) async {
    if (event.query.isEmpty) {
      emit(const ProductState.initial());
      return;
    }

    emit(const ProductState.loading());

    try {
      final results = await repository.searchProducts(event.query);
      emit(ProductState.loaded(results));
    } catch (e) {
      emit(ProductState.error(e.toString()));
    }
  }
}