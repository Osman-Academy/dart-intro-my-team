import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductsRequested extends ProductsEvent {
  const ProductsRequested();
}

class ProductsSearchChanged extends ProductsEvent {
  final String query;
  const ProductsSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class ProductsSearchCleared extends ProductsEvent {
  const ProductsSearchCleared();
}

