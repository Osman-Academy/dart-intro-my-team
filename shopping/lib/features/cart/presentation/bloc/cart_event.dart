part of 'cart_bloc.dart';

@freezed
sealed class CartEvent with _$CartEvent {
  const factory CartEvent.load() = _Load;
  const factory CartEvent.add({
    required Product product,
    @Default(1) int quantity,
  }) = _Add;
  const factory CartEvent.remove(int productId) = _Remove;
  const factory CartEvent.updateQuantity({
    required int productId,
    required int quantity,
  }) = _UpdateQuantity;
  const factory CartEvent.clear() = _Clear;
}
