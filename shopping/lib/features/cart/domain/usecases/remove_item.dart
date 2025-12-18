import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class RemoveItem {
  RemoveItem(this._repository);

  final CartRepository _repository;

  Future<Cart> call(int productId) => _repository.removeItem(productId);
}
