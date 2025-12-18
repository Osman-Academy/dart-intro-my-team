import '../../domain/usecases/get_products.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProducts;

  ProductBloc(this.getProducts) : super(const ProductState.loading()) {
    on<LoadProducts>((event, emit) async {
      emit(const ProductState.loading());
      try {
        final products = await getProducts(NoParams());
        emit(ProductState.loaded(products));
      } catch (e) {
        emit(ProductState.error(e.toString()));
      }
    });
  }
}

