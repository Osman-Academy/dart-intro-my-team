import 'package:auth_app/models/product.dart';

abstract class ProductState {}

class ProductStateInitial implements ProductState {}

class ProductStateLoading implements ProductState {}

class ProductStateSuccess implements ProductState {
  final List<Product> products;
  final List<Product> cartItems;
  ProductStateSuccess({required this.products, this.cartItems = const []});
}

class ProductStateView implements ProductState {
  final Product product;
  final List<Product> cartItems;
  ProductStateView({required this.product, this.cartItems = const []});
}

class ProductCartUpdated implements ProductState {
  final List<Product> cartItems;
  ProductCartUpdated({required this.cartItems});
}

class ProductStateError implements ProductState {
  final String message;
  ProductStateError({required this.message});
}