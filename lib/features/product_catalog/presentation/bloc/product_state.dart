import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.loading() = Loading;
  const factory ProductState.loaded(List<Product> products) = Loaded;
  const factory ProductState.error(String message) = Error;
}
