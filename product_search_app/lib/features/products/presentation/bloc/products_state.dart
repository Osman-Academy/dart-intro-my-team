import 'package:freezed_annotation/freezed_annotation.dart';
import '../../products.dart';

part 'products_state.freezed.dart';

enum ProductsStatus { initial, loading, success, failure }

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState({
    @Default(ProductsStatus.initial) ProductsStatus status,
    @Default(<Product>[]) List<Product> products,
    @Default(<Product>[]) List<Product> filtered,
    @Default('') String query,
    String? errorMessage,
  }) = _ProductsState;
}
