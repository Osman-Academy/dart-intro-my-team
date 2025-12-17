part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.loadProducts() = _LoadProducts;
  const factory ProductEvent.searchProducts(String pattern) = _SearchProducts;
  const factory ProductEvent.loadProductDetails(int id) = _LoadProductDetails;
}
