// presentation/bloc/product_bloc.dart
import 'package:final_products_app/core/resources/data_state.dart';
import 'package:final_products_app/features/domain/models/product.dart';
import 'package:final_products_app/features/domain/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  List<Product> _allProducts = [];

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      final result = await repository.getProducts();

      if (result is DataSuccess<List<Product>>) {
        _allProducts = result.data!;
        emit(ProductLoaded(_allProducts));
      } else if (result is DataFailure) {
        emit(ProductError('Loading error'));
      }
    });
  }
}
