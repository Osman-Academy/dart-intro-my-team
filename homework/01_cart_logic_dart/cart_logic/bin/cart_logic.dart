import '../lib/models/item.dart';
import '../lib/models/category.dart';
import '../lib/services/cart_service.dart';

void main() {
  final iphone17Pro     = Item(name: "iPhone 17 Pro",     price: 1099.00);
  final iphone17        = Item(name: "iPhone 17",          price: 799.00);
  final iphoneAir       = Item(name: "iPhone Air",         price: 999.00);
  final iphone16ProMax  = Item(name: "iPhone 16 Pro Max",  price: 1299.99);
  final iphone16Pro     = Item(name: "iPhone 16 Pro",      price: 999.99);
  final iphone16        = Item(name: "iPhone 16",          price: 729.99);
  final iphone15Plus    = Item(name: "iPhone 15 Plus",     price: 829.99);

  final iPhones = Category(
    name: "iPhones (Apple)",
    items: [
      iphone17Pro,
      iphone17,
      iphoneAir,
      iphone16ProMax,
      iphone16Pro,
      iphone16,
      iphone15Plus,
    ],
  );

  final cart = CartService();

  for (final item in iPhones.items) {
    cart.addItem(item);
  }

  cart.printCart();

  cart.removeItem(iphone16);
  cart.printCart();
}
