import 'package:navigation/models/product.dart';

abstract class ProductState {}

class ProductStateInitial implements ProductState {}

class ProductStateLoading implements ProductState {}

class ProductStateSuccess implements ProductState {
  final List<Product> products;
  ProductStateSuccess({required this.products});
}

class ProductStateView implements ProductState {
  final Product product;
  ProductStateView({required this.product});
}
