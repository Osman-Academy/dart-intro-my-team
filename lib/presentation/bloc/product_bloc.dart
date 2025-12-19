import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';

part 'product_bloc.freezed.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  const factory ProductEvent.searchChanged(String query) = _SearchChanged;
}

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.loaded({
    required List<ProductEntity> allProducts,
    required List<ProductEntity> filteredProducts,
  }) = _Loaded;
  const factory ProductState.error(String message) = _Error;
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductBloc({required this.getProductsUseCase}) : super(const _Initial()) {
    on<_Started>(_onStarted);
    on<_SearchChanged>(_onSearchChanged);
  }

  Future<void> _onStarted(_Started event, Emitter<ProductState> emit) async {
    emit(const ProductState.loading());
    try {
      final products = await getProductsUseCase();
      emit(ProductState.loaded(
        allProducts: products, 
        filteredProducts: products
      ));
    } catch (e) {
      emit(ProductState.error(e.toString()));
    }
  }

  void _onSearchChanged(_SearchChanged event, Emitter<ProductState> emit) {
    state.mapOrNull(loaded: (currentState) {
      final query = event.query.toLowerCase();
      
      final filtered = currentState.allProducts.where((product) {
        return product.title.toLowerCase().contains(query);
      }).toList();

      emit(currentState.copyWith(filteredProducts: filtered));
    });
  }
}