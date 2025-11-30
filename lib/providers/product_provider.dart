import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider with ChangeNotifier {
  final _service = ProductService();
  List<Product> _products = [];
  List<String> _categories = [];
  bool isLoading = false;
  String? errorMessage;
  String? _selectedCategory;
  String _searchQuery = '';

  List<Product> get products => _products;
  List<String> get categories => _categories;
  String? get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  List<Product> get filteredProducts {
    return _products.where((p) {
      final matchesCategory = _selectedCategory == null || _selectedCategory!.isEmpty
          ? true
          : p.category == _selectedCategory;
      final q = _searchQuery.toLowerCase();
      final matchesSearch = q.isEmpty
          ? true
          : p.name.toLowerCase().contains(q) || p.description.toLowerCase().contains(q);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Future<void> loadProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      _products = await _service.getProducts(
        search: _searchQuery.isEmpty ? null : _searchQuery,
        category: _selectedCategory,
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCategories() async {
    try {
      _categories = await _service.getCategories();
      notifyListeners();
    } catch (e) {
    }
  }

  void applySearch(String search) {
    _searchQuery = search;
    loadProducts();
  }

  void selectCategory(String? category) {
    _selectedCategory = category;
    loadProducts();
  }

  Product? findById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
