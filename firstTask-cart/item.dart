import 'category.dart';

class Item {
  String name;
  Category category;
  double price;

  Item(this.name, this.category, this.price);

  double getDiscount() => price * category.getDiscountRate();

  double getFinalPrice() => price - getDiscount();

  void printInfo() {
    print("Name: $name");
    print("Category: ${category.name}");
    print("Price: \$${price.toStringAsFixed(2)}");
    print("Discount: \$${getDiscount().toStringAsFixed(2)}");
    print("Final Price: \$${getFinalPrice().toStringAsFixed(2)}");
    print("----------------------------------");
  }
}
