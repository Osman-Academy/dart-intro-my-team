import 'category.dart';
import 'item.dart';
import 'cart.dart';

void main() {
  // Create categories
  Category food = Category("Food");
  Category clothing = Category("Clothing");
  Category electronics = Category("Electronics");
  Category stationery = Category("Stationery");

  // Create items
  Item apple = Item("Apple", food, 3.0);
  Item jacket = Item("Jacket", clothing, 120.0);
  Item phone = Item("Phone", electronics, 900.0);
  Item book = Item("Book", stationery, 20.0);

  // Print information about each item
  apple.printInfo();
  jacket.printInfo();
  phone.printInfo();
  book.printInfo();

  // Create a shopping cart
  Cart cart = Cart();

  // Add items to the cart
  cart.addItem(apple);     
  cart.addItem(apple);     
  cart.addItem(jacket);     
  cart.addItem(phone);      
  cart.addItem(book);      

  // Print cart contents
  cart.printCart();

  // Decrease the quantity of apples by 1
  cart.decreaseItem(apple);
  cart.printCart();

  // Remove phone from the cart completely
  cart.removeItem(phone);
  cart.printCart();
}
