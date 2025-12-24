part of 'products_bloc.dart';

@freezed
sealed class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loading({@Default([]) List<Product> products}) =
      _Loading;
  const factory ProductsState.loadSuccess({
    required List<Product> products,
  }) = _LoadSuccess;
  const factory ProductsState.detailSuccess({
    required Product product,
  }) = _DetailSuccess;
  const factory ProductsState.searchSuccess({
    required List<Product> products,
    required String query,
  }) = _SearchSuccess;
  const factory ProductsState.failure(String message) = _Failure;
}
