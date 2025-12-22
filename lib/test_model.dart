import 'data/product_model.dart';

void main() {
  // Match the field names exactly: id and title
  final product = ProductModel(
    id: 1,
    title: 'Laptop',
  );

  // Print JSON for testing
  print(product.toJson());
}
