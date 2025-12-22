import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../../domain/entities/cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial());

  void add(ProductModel product) {
    final map = Map<String, CartItem>.from(state.itemsById);

    final existing = map[product.id];
    if (existing == null) {
      map[product.id] = CartItem(product: product, quantity: 1);
    } else {
      map[product.id] = existing.copyWith(quantity: existing.quantity + 1);
    }

    emit(state.copyWith(itemsById: map));
  }

  void remove(String productId) {
    final map = Map<String, CartItem>.from(state.itemsById);
    map.remove(productId);
    emit(state.copyWith(itemsById: map));
  }

  void increase(String productId) {
    final map = Map<String, CartItem>.from(state.itemsById);
    final item = map[productId];
    if (item == null) return;

    map[productId] = item.copyWith(quantity: item.quantity + 1);
    emit(state.copyWith(itemsById: map));
  }

  void decrease(String productId) {
    final map = Map<String, CartItem>.from(state.itemsById);
    final item = map[productId];
    if (item == null) return;

    final nextQty = item.quantity - 1;
    if (nextQty <= 0) {
      map.remove(productId);
    } else {
      map[productId] = item.copyWith(quantity: nextQty);
    }

    emit(state.copyWith(itemsById: map));
  }

  void clear() {
    emit(CartState.initial());
  }
}

