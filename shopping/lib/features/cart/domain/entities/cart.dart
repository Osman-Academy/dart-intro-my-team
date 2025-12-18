import 'package:equatable/equatable.dart';

import 'cart_item.dart';

class Cart extends Equatable {
  const Cart({
    this.items = const [],
  });

  final List<CartItem> items;

  num get total => items.fold<num>(0, (sum, item) => sum + item.lineTotal);
  int get totalItems =>
      items.fold<int>(0, (sum, item) => sum + item.quantity);

  @override
  List<Object?> get props => [items];
}
