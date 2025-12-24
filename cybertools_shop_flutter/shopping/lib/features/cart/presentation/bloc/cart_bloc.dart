import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../../products/domain/entities/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._repository) : super(const CartState.initial()) {
    on<_Load>(_onLoad);
    on<_Add>(_onAdd);
    on<_Remove>(_onRemove);
    on<_UpdateQuantity>(_onUpdateQuantity);
    on<_Clear>(_onClear);
  }

  final CartRepository _repository;

  Future<void> _onLoad(_Load event, Emitter<CartState> emit) async {
    emit(const CartState.loading());
    final cart = await _repository.getCart();
    emit(CartState.loaded(cart));
  }

  Future<void> _onAdd(_Add event, Emitter<CartState> emit) async {
    final cart = await _repository.addItem(
      CartItem(product: event.product, quantity: event.quantity),
    );
    emit(CartState.loaded(cart));
  }

  Future<void> _onRemove(_Remove event, Emitter<CartState> emit) async {
    final cart = await _repository.removeItem(event.productId);
    emit(CartState.loaded(cart));
  }

  Future<void> _onUpdateQuantity(
    _UpdateQuantity event,
    Emitter<CartState> emit,
  ) async {
    final cart =
        await _repository.updateQuantity(event.productId, event.quantity);
    emit(CartState.loaded(cart));
  }

  Future<void> _onClear(_Clear event, Emitter<CartState> emit) async {
    final cart = await _repository.clear();
    emit(CartState.loaded(cart));
  }
}
