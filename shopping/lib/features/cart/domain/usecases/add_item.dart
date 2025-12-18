import '../entities/cart.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class AddItem {
  AddItem(this._repository);

  final CartRepository _repository;

  Future<Cart> call(CartItem item) => _repository.addItem(item);
}
