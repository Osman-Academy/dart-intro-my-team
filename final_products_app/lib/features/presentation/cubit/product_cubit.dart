import 'package:final_products_app/core/resources/data_state.dart';
import 'package:final_products_app/features/domain/models/product.dart';
import 'package:final_products_app/features/domain/repository/product_repository.dart';
import 'package:final_products_app/features/presentation/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState>{
  final ProductRepository productRepository;

  ProductCubit(this.productRepository): super(ProductInitial()) {
    emit(ProductLoading());
  }

  void getProducts() async {
    final products = await productRepository.getProducts();
    if (products is DataSuccess<List<Product>>) {
      emit(ProductLoaded(products.data!));
    } else {
      emit(ProductError("Unexpected error"));
    }
  }
}