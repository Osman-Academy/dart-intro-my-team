import 'package:navigation/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => (product.price ?? 0) * quantity;

  Map<String, dynamic> toJson() {
    return {
      'product': {
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'thumbnail': product.thumbnail,
        'description': product.description,
        'category': product.category,
      },
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.formJson(json['product']),
      quantity: json['quantity'] ?? 1,
    );
  }

  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }
}

class Cart {
  List<CartItem> items;

  Cart({List<CartItem>? items}) : items = items ?? [];

  double get totalPrice {
    return items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  void addItem(Product product) {
    final existingIndex =
        items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      items[existingIndex].quantity++;
    } else {
      items.add(CartItem(product: product));
    }
  }

  void removeItem(Product product) {
    items.removeWhere((item) => item.product.id == product.id);
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      removeItem(product);
      return;
    }

    final existingIndex =
        items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      items[existingIndex] = items[existingIndex].copyWith(quantity: quantity);
    }
  }

  void incrementQuantity(Product product) {
    final existingIndex =
        items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      items[existingIndex].quantity++;
    }
  }

  void decrementQuantity(Product product) {
    final existingIndex =
        items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      if (items[existingIndex].quantity > 1) {
        items[existingIndex].quantity--;
      } else {
        removeItem(product);
      }
    }
  }

  void clear() {
    items.clear();
  }

  bool contains(Product product) {
    return items.any((item) => item.product.id == product.id);
  }

  int getQuantity(Product product) {
    final existingIndex =
        items.indexWhere((item) => item.product.id == product.id);
    return existingIndex >= 0 ? items[existingIndex].quantity : 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List?)
            ?.map((item) => CartItem.fromJson(item))
            .toList() ??
        [];
    return Cart(items: items);
  }
}
