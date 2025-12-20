import 'package:flutter/material.dart';
import '../../domain/entities/camera.dart';

class CartProvider extends ChangeNotifier {
  final List<Camera> _items = [];
  List<Camera> get items => _items;

  double get totalPrice => _items.fold(0, (total, current) => total + current.price);

  void addToCart(Camera camera) {
    _items.add(camera);
    notifyListeners();
  }

  void removeFromCart(Camera camera) {
    _items.remove(camera);
    notifyListeners();
  }
  
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
