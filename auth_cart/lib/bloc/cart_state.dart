import 'package:navigation/models/cart.dart';

abstract class CartState {}

class CartStateInitial implements CartState {}

class CartStateLoading implements CartState {}

class CartStateLoaded implements CartState {
  final Cart cart;

  CartStateLoaded({required this.cart});
}

class CartStateError implements CartState {
  final String message;

  CartStateError({required this.message});
}

class CartStateCheckoutSuccess implements CartState {
  final Cart cart;
  final String orderId;

  CartStateCheckoutSuccess({required this.cart, required this.orderId});
}
