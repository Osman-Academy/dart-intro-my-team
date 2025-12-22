import '../../domain/entities/cart_item.dart';

class CartState {
  final Map<String, CartItem> itemsById;

  const CartState({
    required this.itemsById,
  });

  factory CartState.initial() => const CartState(itemsById: {});

  List<CartItem> get items => itemsById.values.toList();

  int get totalItems =>
      itemsById.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => itemsById.values.fold(
    0.0,
        (sum, item) => sum + item.product.price * item.quantity,
  );

  CartState copyWith({
    Map<String, CartItem>? itemsById,
  }) {
    return CartState(
      itemsById: itemsById ?? this.itemsById,
    );
  }
}
