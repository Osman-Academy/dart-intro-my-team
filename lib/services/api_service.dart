import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  final String baseUrl;
  ApiService({this.baseUrl = 'https://dummyjson.com'});
  Future<List<Product>> fetchProducts({String? search, String? category}) async {
    Uri uri;
    if (search != null && search.isNotEmpty) {
      uri = Uri.parse('$baseUrl/c/2bbd-3c01-482e-9a10/search?q=$search');
    } else if (category != null && category.isNotEmpty) {
      uri = Uri.parse('$baseUrl/c/2bbd-3c01-482e-9a10/category/$category');
    } else {
      uri = Uri.parse('$baseUrl/c/2bbd-3c01-482e-9a10');
    }

    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(res.body);
      final List list = data['products'] as List? ?? [];
      return list.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<String>> fetchCategories() async {
    final res = await http.get(Uri.parse('$baseUrl/c/8d29-0e88-4c55-a42e'));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body) as List;
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
