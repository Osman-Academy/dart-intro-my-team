import 'cart-item.dart';
import 'category.dart';
import 'item.dart';

void main() {
  final electronicsCategory = Category(id: 1, name: 'Electronics');
  final clothingCategory = Category(id: 2, name: 'Clothing');
  final booksCategory = Category(id: 3, name: 'Books');

  final Item laptop = Item(id: 1, name: 'Laptop', price: 850, category: electronicsCategory);
  final Item tshirt = Item(id: 2, name: 'T-Shirt', price: 25, category: clothingCategory);
  final Item novel = Item(id: 3, name: 'Mystery Novel', price: 40, category: booksCategory);

  final CartItem cartLaptop = CartItem(item: laptop, quantity: 1);
  final CartItem cartTshirt = CartItem(item: tshirt, quantity: 3);
  final CartItem cartNovel = CartItem(item: novel, quantity: 2);

  final List<CartItem> cart = [];

  cart.addAll([cartLaptop, cartTshirt, cartNovel]);

  for (var cartItem in cart) {
    print(
        '${cartItem.item.id}. Name: ${cartItem.item.name}, Price: \$${cartItem.item.price}, '
        'Category: ${cartItem.item.category.name}, Quantity: ${cartItem.quantity}');
  }
}
