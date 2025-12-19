import 'package:injectable/injectable.dart';
import 'package:string_search_app/domain/entities/product.dart';
import 'package:string_search_app/domain/repositories/product_repository.dart';

@injectable
class SearchProducts {
  final ProductRepository repository;

  SearchProducts(this.repository);

  Future<List<Product>> call(String pattern) async {
    final products = await repository.getProducts();
    return products
        .where((p) => p.title.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }
}