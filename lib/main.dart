import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'managers/cart_manager.dart';
import 'models/cart_item.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ORT Prep Demo',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(title: const Text('ORT Prep — Cart Demo')),
      body: Column(
        children: [
          ListTile(
            title: const Text('Sample Item (Math)'),
            subtitle: const Text('Category: Math'),
            trailing: ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                cart.addItem(CartItem(
                  id: 'q1',
                  title: 'Algebra practice pack',
                  categoryId: 'math',
                  price: 0.0,
                  quantity: 1,
                ));
              },
            ),
          ),
          const Divider(),
          Text('Total items: ${cart.totalItems}'),
          Text('Total price: ${cart.totalPrice}'),
        ],
      ),
    );
  }
}
