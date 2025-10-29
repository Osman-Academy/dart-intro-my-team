import 'cart-item.dart';
import 'category.dart';
import 'item.dart';

void main() {
  final foodCategory = new Category(id: 1, name: 'Food');
  final beveragesCategory = new Category(id: 2, name: 'Beverages');
  final sportsCategory = new Category(id: 2, name: 'Sports');

  final Item bread = new Item(id: 1, name: 'Bread', price: 12, category: foodCategory);
  final Item cola = new Item(id: 2, name: 'Coca-Cola', price: 30, category: beveragesCategory);
  final Item stretcher = new Item(id: 3, name: 'Stretcher', price: 300, category: sportsCategory);


  final CartItem cartBread = new CartItem(item: bread, quantity: 5);
  final CartItem cartCola = new CartItem(item: cola, quantity: 2);
  final CartItem cartStretcher = new CartItem(item: stretcher, quantity: 1);

  final List<CartItem> cart = [];
  
  cart.addAll([cartStretcher, cartCola, cartBread]);

  for (var CartItem in cart) {
    print('${CartItem.item.id}. Name: ${CartItem.item.name}, Price: ${CartItem.item.price}, Category: ${CartItem.item.category.name}, Quantity: ${CartItem.quantity}');
  }
}
