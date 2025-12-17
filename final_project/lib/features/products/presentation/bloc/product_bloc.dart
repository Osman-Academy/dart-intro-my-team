import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  List<Product> allProducts = [];

  ProductBloc(this.getProducts) : super(ProductLoading()) {
    on<LoadProducts>((event, emit) async {
      allProducts = await getProducts();
      emit(ProductLoaded(allProducts));
    });

    on<SearchProducts>((event, emit) {
      final filtered = allProducts
          .where((p) =>
              p.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      emit(ProductLoaded(filtered));
    });
  }
}
