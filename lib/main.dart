import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'managers/cart_manager.dart';
import 'models/cart_item.dart';
import 'widgets/shrinking_square.dart';
import 'repositories/auth_repository.dart';
import 'services/auth_service.dart';
import 'pages/login_page.dart';

void main() {
  final authRepo = AuthRepository();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartManager()),
        ChangeNotifierProvider(create: (_) => AuthService(authRepo)),
      ],
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
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Interactive Square (tap to shrink)'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const LoginPage()),
            ),
            child: Text(context.watch<AuthService>().isAuthenticated ? 'Logged In' : 'Login'),
          ),
          const SizedBox(height: 8),
          const ShrinkingSquare(maxSize: 220, minSize: 40),
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
