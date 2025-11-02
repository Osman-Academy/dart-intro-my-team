import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_app/bloc/product_event.dart';
import 'package:auth_app/bloc/product_state.dart';
import 'package:auth_app/models/product.dart';
import 'package:auth_app/models/product_dto.dart';
import 'package:auth_app/repositories/repository_product_remote.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  RepositoryProductRemote repository = RepositoryProductRemote();
  List<Product> _cartItems = [];

  ProductBloc() : super(ProductStateInitial()) {
    on<ProductLoadEvent>((event, emit) async {
      emit(ProductStateLoading());
      try {
        var result = await repository.list(ProductDto());
        emit(ProductStateSuccess(products: result, cartItems: _cartItems));
      } catch (e) {
        emit(ProductStateError(message: 'Failed to load products: $e'));
      }
    });

    on<ProductEventView>((event, emit) async {
      emit(ProductStateLoading());
      try {
        var result = await repository.view(ProductDto(productId: event.productId));
        emit(ProductStateView(product: result, cartItems: _cartItems));
      } catch (e) {
        final currentState = state;
        if (currentState is ProductStateSuccess) {
          emit(ProductStateSuccess(products: currentState.products, cartItems: _cartItems));
        } else {
          emit(ProductStateError(message: 'Failed to load product: $e'));
        }
      }
    });

    on<AddToCartEvent>((event, emit) {
      _cartItems.add(event.product);
      final currentState = state;
      if (currentState is ProductStateSuccess) {
        emit(ProductStateSuccess(products: currentState.products, cartItems: _cartItems));
      } else if (currentState is ProductStateView) {
        emit(ProductStateView(product: currentState.product, cartItems: _cartItems));
      } else {
        emit(ProductCartUpdated(cartItems: _cartItems));
      }
    });

    on<RemoveFromCartEvent>((event, emit) {
      _cartItems.removeWhere((item) => item.id == event.product.id);
      final currentState = state;
      if (currentState is ProductStateSuccess) {
        emit(ProductStateSuccess(products: currentState.products, cartItems: _cartItems));
      } else if (currentState is ProductStateView) {
        emit(ProductStateView(product: currentState.product, cartItems: _cartItems));
      } else {
        emit(ProductCartUpdated(cartItems: _cartItems));
      }
    });

    on<ClearCartEvent>((event, emit) {
      _cartItems.clear();
      final currentState = state;
      if (currentState is ProductStateSuccess) {
        emit(ProductStateSuccess(products: currentState.products, cartItems: _cartItems));
      } else {
        emit(ProductCartUpdated(cartItems: _cartItems));
      }
    });
  }
}