// lib/main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Product {
  final int id;
  final String name;
  final double price;
  Product({required this.id, required this.name, required this.price});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Cart Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CartDemoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CartDemoPage extends StatefulWidget {
  const CartDemoPage({super.key});

  @override
  State<CartDemoPage> createState() => _CartDemoPageState();
}

class _CartDemoPageState extends State<CartDemoPage> {
  // Predefined product catalog (4-5 products)
  final List<Product> products = [
    Product(id: 1, name: 'Blue T-shirt', price: 19.99),
    Product(id: 2, name: 'Sneakers', price: 49.99),
    Product(id: 3, name: 'Backpack', price: 34.50),
    Product(id: 4, name: 'Cap', price: 12.00),
    Product(id: 5, name: 'Water Bottle', price: 9.75),
  ];

  // Cart represented as a list of Product items (initially empty)
  final List<Product> cart = [];

  void addToCart(Product p) {
    setState(() => cart.add(p));
  }

  void removeFromCartAt(int index) {
    setState(() => cart.removeAt(index));
  }

  void clearCart() {
    setState(() => cart.clear());
  }

  double get total =>
      cart.fold(0.0, (previousValue, element) => previousValue + element.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Flutter Web Cart'),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        // Responsive: show side-by-side on wide screens, stacked on narrow screens
        final bool wide = constraints.maxWidth >= 800;
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: wide
              ? Row(
                  children: [
                    Expanded(flex: 3, child: productListCard()),
                    const SizedBox(width: 12),
                    SizedBox(width: 360, child: cartCard()),
                  ],
                )
              : Column(
                  children: [
                    Expanded(child: productListCard()),
                    const SizedBox(height: 12),
                    SizedBox(height: 300, child: cartCard()),
                  ],
                ),
        );
      }),
    );
  }

  Widget productListCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: products.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final p = products[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('\$${p.price.toStringAsFixed(2)}'),
                    trailing: ElevatedButton(
                      onPressed: () => addToCart(p),
                      child: const Text('Buy'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cartCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (cart.isEmpty)
              const Expanded(
                child: Center(
                  child: Text('Cart is empty', style: TextStyle(fontSize: 16)),
                ),
              )
            else
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: cart.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, idx) {
                          final item = cart[idx];
                          return ListTile(
                            dense: true,
                            title: Text(item.name),
                            subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: 'Delete this item',
                                  onPressed: () => removeFromCartAt(idx),
                                  icon: const Icon(Icons.delete_outline),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Items: ${cart.length}', style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text('Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: cart.isEmpty ? null : clearCart,
                  icon: const Icon(Icons.delete_sweep),
                  label: const Text('Clear Cart'),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () {
                    // For demo: show a simple snackbar summary
                    final message = cart.isEmpty
                        ? 'Cart is empty'
                        : 'You have ${cart.length} item(s) — total \$${total.toStringAsFixed(2)}';
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                  },
                  child: const Text('Checkout (demo)'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
