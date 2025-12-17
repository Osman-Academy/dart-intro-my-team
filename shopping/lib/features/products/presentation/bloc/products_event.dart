part of 'products_bloc.dart';

@freezed
sealed class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.fetchProducts() = _FetchProducts;
  const factory ProductsEvent.fetchProduct(int id) = _FetchProduct;
  const factory ProductsEvent.searchProducts(String query) = _SearchProducts;
}
