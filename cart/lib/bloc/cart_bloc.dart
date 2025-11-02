// lib/bloc/cart_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/models/product.dart';

// Events
abstract class CartEvent {}

class CartAddItemEvent extends CartEvent {
  final Product product;
  CartAddItemEvent(this.product);
}

class CartRemoveItemEvent extends CartEvent {
  final Product product;
  CartRemoveItemEvent(this.product);
}

class CartUpdateQuantityEvent extends CartEvent {
  final Product product;
  final int quantity;
  CartUpdateQuantityEvent(this.product, this.quantity);
}

class CartClearEvent extends CartEvent {}

// States
abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartItem> items;
  final List<CartCategory> categories;
  final double totalPrice;
  final int totalItems;

  CartLoadedState({
    required this.items,
    required this.categories,
    required this.totalPrice,
    required this.totalItems,
  });
}

// Models для корзины
class CartItem {
  final Product product;
  int quantity;
  
  CartItem({
    required this.product,
    this.quantity = 1,
  });
  
  double get totalPrice => (product.price ?? 0.0) * quantity;
}

class CartCategory {
  final String categoryName;
  final List<CartItem> items;
  
  CartCategory({
    required this.categoryName,
    required this.items,
  });
  
  double get categoryTotal {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
}

// BLoC
class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItem> _items = [];
  
  CartBloc() : super(CartInitialState()) {
    on<CartAddItemEvent>(_addItem);
    on<CartRemoveItemEvent>(_removeItem);
    on<CartUpdateQuantityEvent>(_updateQuantity);
    on<CartClearEvent>(_clearCart);
  }
  
  void _addItem(CartAddItemEvent event, Emitter<CartState> emit) {
    final existingIndex = _items.indexWhere((item) => item.product.id == event.product.id);
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: event.product));
    }
    
    emit(_buildLoadedState());
  }
  
  void _removeItem(CartRemoveItemEvent event, Emitter<CartState> emit) {
    _items.removeWhere((item) => item.product.id == event.product.id);
    emit(_buildLoadedState());
  }
  
  void _updateQuantity(CartUpdateQuantityEvent event, Emitter<CartState> emit) {
    final existingIndex = _items.indexWhere((item) => item.product.id == event.product.id);
    
    if (existingIndex >= 0) {
      if (event.quantity <= 0) {
        _items.removeAt(existingIndex);
      } else {
        _items[existingIndex].quantity = event.quantity;
      }
    }
    
    emit(_buildLoadedState());
  }
  
  void _clearCart(CartClearEvent event, Emitter<CartState> emit) {
    _items.clear();
    emit(_buildLoadedState());
  }
  
  CartLoadedState _buildLoadedState() {
    // Группировка по категориям
    final Map<String, List<CartItem>> grouped = {};
    
    for (final item in _items) {
      final category = item.product.category ?? 'Uncategorized';
      grouped.putIfAbsent(category, () => []).add(item);
    }
    
    final categories = grouped.entries
        .map((entry) => CartCategory(
              categoryName: entry.key,
              items: entry.value,
            ))
        .toList();
    
    // ИСПРАВЛЕНИЕ: используем 0.0 вместо 0 для double
    final totalPrice = _items.fold(0.0, (double sum, item) => sum + item.totalPrice);
    final totalItems = _items.fold(0, (int sum, item) => sum + item.quantity);
    
    return CartLoadedState(
      items: List.from(_items),
      categories: categories,
      totalPrice: totalPrice,
      totalItems: totalItems,
    );
  }
}