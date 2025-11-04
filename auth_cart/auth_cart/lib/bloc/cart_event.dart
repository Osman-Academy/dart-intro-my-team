import 'package:navigation/models/product.dart';

abstract class CartEvent {}

class CartLoadEvent implements CartEvent {}

class CartAddItemEvent implements CartEvent {
  final Product product;

  CartAddItemEvent({required this.product});
}

class CartRemoveItemEvent implements CartEvent {
  final Product product;

  CartRemoveItemEvent({required this.product});
}

class CartUpdateQuantityEvent implements CartEvent {
  final Product product;
  final int quantity;

  CartUpdateQuantityEvent({required this.product, required this.quantity});
}

class CartIncrementQuantityEvent implements CartEvent {
  final Product product;

  CartIncrementQuantityEvent({required this.product});
}

class CartDecrementQuantityEvent implements CartEvent {
  final Product product;

  CartDecrementQuantityEvent({required this.product});
}

class CartClearEvent implements CartEvent {}

class CartCheckoutEvent implements CartEvent {}
