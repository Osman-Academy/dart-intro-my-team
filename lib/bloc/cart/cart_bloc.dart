import 'package:navigation/models/cart_item.dart';
import 'package:navigation/bloc/cart/cart_event.dart';
import 'package:navigation/bloc/cart/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final Map<int, CartItem> _items = {};
  
  CartBloc() : super(CartLoading()) {
    
      on<CartAddEvent>((event, emit) {
      final productId = event.product.id!;
      
      if (_items.containsKey(productId)) {
        _items[productId]!.quantity++;
      } else {
        _items[productId] = CartItem(event.product, 1);
      }
      
      _showUpdatedCart(emit);
    });
    
    on<CartRemoveEvent>((event, emit) {
      _items.remove(event.productId);
      _showUpdatedCart(emit);
    });
    
    on<CartChangeQuantityEvent>((event, emit) {
      if (_items.containsKey(event.productId)) {
        if (event.newQuantity <= 0) {
          _items.remove(event.productId);
        } else {
          _items[event.productId]!.quantity = event.newQuantity;
        }
      }
      _showUpdatedCart(emit);
    });
  }
  
  void _showUpdatedCart(Emitter<CartState> emit) {
    final Map<String, List<CartItem>> byCategory = {};
    double total = 0;
    int count = 0;
    
    for (var item in _items.values) {
      final category = item.product.category ?? "Другое";
      
      if (!byCategory.containsKey(category)) {
        byCategory[category] = [];
      }
      
      byCategory[category]!.add(item);
      
      total += item.totalPrice;
      count += item.quantity;
    }
    
    emit(CartLoaded(byCategory, total, count));
  }
}