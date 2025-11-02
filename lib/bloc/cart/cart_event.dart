import 'package:navigation/models/product.dart';

abstract class CartEvent {}

class CartAddEvent extends CartEvent {
  final Product product;
  CartAddEvent(this.product);
}

class CartRemoveEvent extends CartEvent {
  final int productId;
  CartRemoveEvent(this.productId);
}

class CartChangeQuantityEvent extends CartEvent {
  final int productId;
  final int newQuantity;
  CartChangeQuantityEvent(this.productId, this.newQuantity);
}
