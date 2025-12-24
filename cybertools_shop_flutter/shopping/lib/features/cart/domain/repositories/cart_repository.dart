import '../entities/cart.dart';
import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<Cart> getCart();
  Future<Cart> addItem(CartItem item);
  Future<Cart> removeItem(int productId);
  Future<Cart> updateQuantity(int productId, int quantity);
  Future<Cart> clear();
}
