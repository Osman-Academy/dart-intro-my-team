import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class UpdateQuantity {
  UpdateQuantity(this._repository);

  final CartRepository _repository;

  Future<Cart> call(int productId, int quantity) =>
      _repository.updateQuantity(productId, quantity);
}
