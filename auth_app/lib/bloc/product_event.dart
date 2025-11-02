import 'package:auth_app/models/product.dart';

abstract class ProductEvent {}

class ProductLoadEvent implements ProductEvent {}

class ProductEventView implements ProductEvent {
  final int productId;
  ProductEventView({required this.productId});
}

class AddToCartEvent implements ProductEvent {
  final Product product;
  AddToCartEvent({required this.product});
}

class RemoveFromCartEvent implements ProductEvent {
  final Product product;
  RemoveFromCartEvent({required this.product});
}

class ClearCartEvent implements ProductEvent {}