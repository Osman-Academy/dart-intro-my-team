import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';

class ProductsState extends Equatable {
  final bool isLoading;
  final List<ProductModel> products;
  final List<ProductModel> filtered;
  final String query;
  final String? error;

  const ProductsState({
    required this.isLoading,
    required this.products,
    required this.filtered,
    required this.query,
    this.error,
  });

  factory ProductsState.initial() => const ProductsState(
    isLoading: false,
    products: [],
    filtered: [],
    query: '',
  );

  ProductsState copyWith({
    bool? isLoading,
    List<ProductModel>? products,
    List<ProductModel>? filtered,
    String? query,
    String? error,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      filtered: filtered ?? this.filtered,
      query: query ?? this.query,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, products, filtered, query, error];
}
