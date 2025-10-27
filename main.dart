class Item {
  String name;
  double price;

  Item(this.name, this.price);
}

class Category {
  String name;
  List<Item> items;

  Category(this.name, this.items);
}

void main() {
  var phone = Item('Phone', 600);
  var laptop = Item('Laptop', 1000);
  var tshirt = Item('T-Shirt', 15);
  var sneakers = Item('Sneakers', 100);

  var electronics = Category('Electronics', [phone, laptop]);
  var fashion = Category('Fashion', [tshirt, sneakers]);

  // Store all categories in a list
  var categories = [electronics, fashion];

  // Display categories and items
  for (var category in categories) {
    print('Category: ${category.name}');
    for (var item in category.items) {
      print(' - ${item.name}: \$${item.price}');
    }
  }
}

