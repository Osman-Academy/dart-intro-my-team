import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository)
      : super(const ProductState(isLoading: true)) {
    loadProducts();
  }

  void loadProducts() {
    final products = repository.getProducts();
    emit(
      state.copyWith(
        products: products,
        filteredProducts: products,
        isLoading: false,
      ),
    );
  }

  void search(String query) {
    final filtered = state.products
        .where(
          (product) =>
              product.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    emit(
      state.copyWith(
        query: query,
        filteredProducts: filtered,
      ),
    );
  }
}
