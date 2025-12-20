import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../services/api_service.dart';
import '../widgets/product_grid_item.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _productsFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _productsFuture = _apiService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Shop'),
        actions: [
          if (!authProvider.isAuthenticated)
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed('/login'),
              child: const Text('Login', style: TextStyle(color: Colors.white)),
            ),
          if (!authProvider.isAuthenticated)
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed('/register'),
              child: const Text('Register', style: TextStyle(color: Colors.white)),
            ),
          if (authProvider.isAuthenticated)
            IconButton(
              icon: const Icon(Icons.dashboard),
              onPressed: () {
                if (authProvider.role == 'admin') {
                  Navigator.of(context).pushNamed('/admin_dashboard');
                } else {
                  Navigator.of(context).pushNamed('/customer_dashboard');
                }
              },
            ),
          if (authProvider.isAuthenticated)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => authProvider.logout(),
            ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          final products = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, i) => ProductGridItem(product: products[i]),
          );
        },
      ),
    );
  }
}
