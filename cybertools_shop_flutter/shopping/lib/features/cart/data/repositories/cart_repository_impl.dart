import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl();

  final List<CartItem> _items = [];

  @override
  Future<Cart> getCart() async {
    return Cart(items: List.unmodifiable(_items));
  }

  @override
  Future<Cart> addItem(CartItem item) async {
    final index = _items.indexWhere((i) => i.product.id == item.product.id);
    if (index >= 0) {
      final existing = _items[index];
      _items[index] =
          existing.copyWith(quantity: existing.quantity + item.quantity);
    } else {
      _items.add(item);
    }
    return getCart();
  }

  @override
  Future<Cart> removeItem(int productId) async {
    _items.removeWhere((i) => i.product.id == productId);
    return getCart();
  }

  @override
  Future<Cart> updateQuantity(int productId, int quantity) async {
    final index = _items.indexWhere((i) => i.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: quantity);
      }
    }
    return getCart();
  }

  @override
  Future<Cart> clear() async {
    _items.clear();
    return getCart();
  }
}
