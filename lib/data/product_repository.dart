import '../data/product_model.dart';

class ProductRepository {
  List<ProductModel> getProducts() {
    return [
      ProductModel(id: 1, title: 'Laptop'),
      ProductModel(id: 2, title: 'Phone'),
      ProductModel(id: 3, title: 'Keyboards'),
    ];
  }
}
