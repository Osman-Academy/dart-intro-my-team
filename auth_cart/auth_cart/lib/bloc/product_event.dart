abstract class ProductEvent {}

class AddToCartEvent implements ProductEvent {}

class ProductLoadEvent implements ProductEvent {}

class ProductEventView implements ProductEvent {
  int productId;
  ProductEventView({required this.productId});
}
