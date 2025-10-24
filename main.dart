

import 'lib/models.dart';
import 'lib/cart.dart';

void main() {
	final fruits = Category(id: 'c1', name: 'Fruits');
	final bakery = Category(id: 'c2', name: 'Bakery');

	final apple = Item(id: 'i1', name: 'Apple', category: fruits, price: 0.75);
	final banana = Item(id: 'i2', name: 'Banana', category: fruits, price: 0.50);
	final croissant = Item(id: 'i3', name: 'Croissant', category: bakery, price: 2.50);

	final cart = Cart();
	cart.addItem(apple, 3);
	cart.addItem(banana, 2);
	cart.addItem(croissant);

	print('--- Cart ---');
	print(cart.summary());

	print('\n--- Items by category ---');
	cart.itemsByCategory().forEach((cat, items) {
		print('$cat:');
		for (final it in items) print('  - $it');
	});

	// Remove an item entirely
	cart.removeItem(banana);

	print('\n--- After removing banana ---');
	print(cart.summary());
}

