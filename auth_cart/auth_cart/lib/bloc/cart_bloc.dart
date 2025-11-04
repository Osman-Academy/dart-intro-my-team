import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navigation/models/cart.dart';
import 'package:navigation/bloc/cart_event.dart';
import 'package:navigation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final SharedPreferences prefs;
  static const String _cartKey = 'user_cart';

  CartBloc({required this.prefs}) : super(CartStateInitial()) {
    on<CartLoadEvent>(_onLoad);
    on<CartAddItemEvent>(_onAddItem);
    on<CartRemoveItemEvent>(_onRemoveItem);
    on<CartUpdateQuantityEvent>(_onUpdateQuantity);
    on<CartIncrementQuantityEvent>(_onIncrementQuantity);
    on<CartDecrementQuantityEvent>(_onDecrementQuantity);
    on<CartClearEvent>(_onClear);
    on<CartCheckoutEvent>(_onCheckout);
  }

  void _onLoad(CartLoadEvent event, Emitter<CartState> emit) async {
    emit(CartStateLoading());

    try {
      final cartJson = prefs.getString(_cartKey);
      Cart cart;

      if (cartJson != null) {
        cart = Cart.fromJson(jsonDecode(cartJson));
      } else {
        cart = Cart();
      }

      emit(CartStateLoaded(cart: cart));
    } catch (e) {
      emit(CartStateError(message: "Failed to load cart"));
    }
  }

  void _onAddItem(CartAddItemEvent event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartStateLoaded) {
      final updatedCart = Cart(items: List.from(currentState.cart.items));
      updatedCart.addItem(event.product);

      await _saveCart(updatedCart);
      emit(CartStateLoaded(cart: updatedCart));
    }
  }

  void _onRemoveItem(CartRemoveItemEvent event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartStateLoaded) {
      final updatedCart = Cart(items: List.from(currentState.cart.items));
      updatedCart.removeItem(event.product);

      await _saveCart(updatedCart);
      emit(CartStateLoaded(cart: updatedCart));
    }
  }

  void _onUpdateQuantity(
      CartUpdateQuantityEvent event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartStateLoaded) {
      final updatedCart = Cart(items: List.from(currentState.cart.items));
      updatedCart.updateQuantity(event.product, event.quantity);

      await _saveCart(updatedCart);
      emit(CartStateLoaded(cart: updatedCart));
    }
  }

  void _onIncrementQuantity(
      CartIncrementQuantityEvent event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartStateLoaded) {
      final updatedCart = Cart(items: List.from(currentState.cart.items));
      updatedCart.incrementQuantity(event.product);

      await _saveCart(updatedCart);
      emit(CartStateLoaded(cart: updatedCart));
    }
  }

  void _onDecrementQuantity(
      CartDecrementQuantityEvent event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartStateLoaded) {
      final updatedCart = Cart(items: List.from(currentState.cart.items));
      updatedCart.decrementQuantity(event.product);

      await _saveCart(updatedCart);
      emit(CartStateLoaded(cart: updatedCart));
    }
  }

  void _onClear(CartClearEvent event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartStateLoaded) {
      final updatedCart = Cart();

      await _saveCart(updatedCart);
      emit(CartStateLoaded(cart: updatedCart));
    }
  }

  void _onCheckout(CartCheckoutEvent event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartStateLoaded) {
      if (currentState.cart.items.isEmpty) {
        emit(CartStateError(message: "Cart is empty"));
        return;
      }

      try {
        // Имитация процесса оформления заказа
        await Future.delayed(const Duration(seconds: 2));

        final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';
        final cart = currentState.cart;

        // Очищаем корзину после успешного оформления
        final emptyCart = Cart();
        await _saveCart(emptyCart);

        emit(CartStateCheckoutSuccess(cart: cart, orderId: orderId));

        // После успешного оформления возвращаемся к пустой корзине
        await Future.delayed(const Duration(milliseconds: 100));
        emit(CartStateLoaded(cart: emptyCart));
      } catch (e) {
        emit(CartStateError(message: "Checkout failed: ${e.toString()}"));
      }
    }
  }

  Future<void> _saveCart(Cart cart) async {
    await prefs.setString(_cartKey, jsonEncode(cart.toJson()));
  }
}
