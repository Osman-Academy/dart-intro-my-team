import 'dart:io';


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

class Cart {
  List<Item> items = [];

  void addItem(Item item) {
    items.add(item);
  }

  void removeItem(Item item) {
    items.remove(item);
  }

  double getTotalPrice() {
    return items.fold(0, (total, item) => total + item.price);
  }
  
  void add(Item item) {
    items.add(item);
    print("${item.name} added to cart.");
  }
  
  void show() {
    print("Cart contents:");
    for (var item in items) {
      print("- ${item.name}: ${item.price} SOM");
    }
    print("Total price: ${getTotalPrice()} SOM");
  }
}
void main() {
  var fruits = Category("Nura's favorite snacks", [Item("Pir chips",130), Item("Banana",35)]);
  var drinks = Category("Nura's favorite drinks", [Item("Piko Pulpy Orange 1L",180), Item("Coke Zero 0.5L",60)]);
  var cart = Cart();
  while(true){
    print("Choose category of items: \n1. Nura's favorite snacks 2. Nura's favorite drinks");

    var c = stdin.readLineSync();
    var cat = c=="1"?fruits:drinks;
    for(int i=0;i<cat.items.length;i++){
      print("${i+1}. ${cat.items[i].name}");
    }

    var it = stdin.readLineSync();
    int? index = int.tryParse(it??"");
    if(index!=null && index>0 && index<=cat.items.length){
      cart.add(cat.items[index-1]);
    }
    print("");
    cart.show();
    print("");
  }
}