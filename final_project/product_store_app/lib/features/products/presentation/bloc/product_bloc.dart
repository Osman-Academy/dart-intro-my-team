import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/search_products.dart';
import '../../domain/usecases/get_product_by_id.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final SearchProducts searchProducts;
  final GetProductById getProductById;

  ProductBloc(
    this.getProducts,
    this.searchProducts,
    this.getProductById,
  ) : super(const ProductState.initial()) {
    on<_LoadProducts>(_onLoadProducts);
    on<_SearchProducts>(_onSearchProducts);
    on<_LoadProductDetails>(_onLoadProductDetails);
  }

  Future<void> _onLoadProducts(
      _LoadProducts event, Emitter<ProductState> emit) async {
    emit(const ProductState.loading());
    final result = await getProducts(NoParams());
    result.fold(
      (failure) => emit(ProductState.error(failure.toString())),
      (products) => emit(ProductState.loaded(products)),
    );
  }

  Future<void> _onSearchProducts(
      _SearchProducts event, Emitter<ProductState> emit) async {
    emit(const ProductState.loading());
    final result = await searchProducts(event.pattern);
    result.fold(
      (failure) => emit(ProductState.error(failure.toString())),
      (products) => emit(ProductState.loaded(products)),
    );
  }

  Future<void> _onLoadProductDetails(
      _LoadProductDetails event, Emitter<ProductState> emit) async {
    emit(const ProductState.loading());
    final result = await getProductById(event.id);
    result.fold(
      (failure) => emit(ProductState.error(failure.toString())),
      (product) => emit(ProductState.productDetails(product)),
    );
  }
}
