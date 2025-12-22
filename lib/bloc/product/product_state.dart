import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/product_model.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default([]) List<ProductModel> products,
    @Default([]) List<ProductModel> filteredProducts,
    @Default('') String query,
    @Default(false) bool isLoading,
  }) = _ProductState;
}
