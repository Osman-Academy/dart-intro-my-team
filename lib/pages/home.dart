import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/product/product_bloc.dart';
import 'package:navigation/bloc/product/product_event.dart';
import 'package:navigation/bloc/product/product_state.dart';
import 'package:navigation/models/product.dart';
import 'package:navigation/pages/detail.dart';
import 'package:navigation/pages/cart.dart';
import 'package:navigation/widgets/dynamic_square.dart';
import 'package:navigation/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navigation/pages/login.dart';
import 'package:navigation/bloc/cart/cart_bloc.dart';
import 'package:navigation/bloc/cart/cart_event.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Product> products = [];
  double _iconSize = 120.0;

  @override
  void initState() {
    super.initState();
    if (products.isEmpty) {
      context.read<ProductBloc>().add(ProductLoadEvent());
    }
  }

  void _handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    final authRepository = AuthRepository(prefs);
    await authRepository.logout();
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login(storage: prefs)),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _handleLogout();
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.tune, color: Colors.white),
              onPressed: () async {
                final newSize = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DynamicIcon(initialSize: _iconSize),
                  ),
                );
                if (newSize != null) {
                  setState(() {
                    _iconSize = newSize;
                  });
                }
              },
              tooltip: 'Display settings',
            ),
            
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cart()),
                );
              },
              tooltip: 'Shopping cart',
            ),
            
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: _showLogoutDialog,
              tooltip: 'Logout',
            ),
          ],
        ),
        
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductStateLoading && products.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            
            if (state is ProductStateSuccess) {
              products = state.products;
              return _buildProductGrid();
            }
            
            if (state is ProductStateInitial && products.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (products.isNotEmpty) {
              return _buildProductGrid();
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'Failed to load products',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductBloc>().add(ProductLoadEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          },
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Cart()),
            );
          },
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: const Icon(Icons.shopping_cart),
          tooltip: 'Open cart',
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    int crossAxisCount = MediaQuery.of(context).size.width ~/ (_iconSize + 20);
    crossAxisCount = crossAxisCount.clamp(2, 4);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildProductCard(products[index]);
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    final cardWidth = _iconSize;
    final imageSize = cardWidth - 20;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Detail(productId: product.id),
          ),
        );
      },
      onLongPress: () {
        context.read<CartBloc>().add(CartAddEvent(product));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.title} added to cart!'),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: cardWidth,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(product.thumbnail ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Expanded(
                child: Text(
                  product.title ?? 'No title',
                  style: TextStyle(
                    fontSize: _calculateFontSize(cardWidth),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                style: TextStyle(
                  fontSize: _calculateFontSize(cardWidth) - 2,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (product.rating != null) ...[
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      product.rating!.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  double _calculateFontSize(double cardWidth) {
    return cardWidth * 0.09;
  }
}