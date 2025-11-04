import 'package:navigation/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/product_event.dart';
import 'package:navigation/bloc/product_state.dart';
import 'package:navigation/models/product_dto.dart';
import 'package:navigation/repositories/repository_product_remote.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  RepositoryProductRemote repository = RepositoryProductRemote();
  ProductBloc() : super(ProductStateInitial()) {
    on<ProductLoadEvent>((event, emit) async {
      var result = await repository.list(ProductDto());
      emit(ProductStateSuccess(products: result));
    });

    on<ProductEventView>((event, emit) async {
      emit(ProductStateLoading());
      var result =
          await repository.view(ProductDto(productId: event.productId));
      emit(ProductStateView(product: result));
    });
  }
}
