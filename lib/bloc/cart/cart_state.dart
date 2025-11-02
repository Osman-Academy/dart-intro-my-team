import 'package:navigation/models/cart_item.dart';

abstract class CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Map<String, List<CartItem>> itemsByCategory;
  final double totalPrice;
  final int totalItems;
  
  CartLoaded(this.itemsByCategory, this.totalPrice, this.totalItems);
}
