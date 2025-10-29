import 'category.dart';
import 'cart.dart';
import 'item.dart';


void main() {
  final electronics = Category('1', 'Electronics');
  final food = Category('2', 'Food');

  final phone = Item('p1', 'Phone', electronics.id, 600);
  final apple = Item('f1', 'Apple', food.id, 2);

  final cart = Cart();
  cart.addItem(phone);
  cart.addItem(apple, quantity: 5);

  cart.printCart();
}
