abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String query;
  SearchProducts(this.query);
}
