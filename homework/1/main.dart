class Cart {
	late List<Item> _items = [];

	Cart (Item item) {
		this._items.add(item);
	}

	Cart.withItems (this._items);
  
  void printInfo () {
    for (Item item in _items) {
      item.printInfo();
    }
  }
} 

class Item {
	String _name = "";
	double _price = 0;
	Category? _category;

	Item ( this._name, this._price, this._category);
  
  void printInfo () {
    print('${_name} - ${_price} - ${_category?.name}');
  }
}

enum Category {
	electronic,
	forHome,
	cooking
}

void main() {
	Cart testCart = Cart.withItems([Item("Laptop", 100.0, Category.electronic), Item("Hair dryer", 20.99, Category.forHome)]);

  print('Our products:');
  testCart.printInfo();
}
