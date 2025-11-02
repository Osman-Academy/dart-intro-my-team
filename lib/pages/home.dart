import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/product_bloc.dart';
import 'package:navigation/bloc/product_event.dart';
import 'package:navigation/bloc/product_state.dart';
import 'package:navigation/bloc/auth_bloc.dart';
import 'package:navigation/bloc/auth_event.dart';
import 'package:navigation/bloc/auth_state.dart';
import 'package:navigation/models/user.dart'; 
import 'package:navigation/models/product.dart';
import 'package:navigation/pages/detail.dart';
import 'package:navigation/pages/home/common/product_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateUnauthenticated) {
          Navigator.of(context).pushReplacementNamed("login");
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Products"),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("login");
                },
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthStateAuthenticated) {
                    return PopupMenuButton<String>(
                      icon: const Icon(Icons.account_circle),
                      onSelected: (value) {
                        if (value == 'logout') {
                          context.read<AuthBloc>().add(AuthLogoutEvent());
                        } else if (value == 'profile') {
                          _showUserProfile(context, state.user);
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'profile',
                          child: Row(
                            children: [
                              const Icon(Icons.person, size: 20),
                              const SizedBox(width: 8),
                              Text('Profile: ${state.user.username}'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'logout',
                          child: Row(
                            children: [
                              Icon(Icons.logout, size: 20),
                              SizedBox(width: 8),
                              Text('Logout'),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return IconButton(
                    icon: const Icon(Icons.login),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("login");
                    },
                  );
                },
              ),
            ],
          ),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is ProductStateSuccess) {
                products = state.products;

                if (products.isEmpty) {
                  return const Center(
                    child: Text(
                      "No products available",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, authState) {
                          if (authState is AuthStateAuthenticated) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              color: Colors.blue[50],
                              child: Row(
                                children: [
                                  const Icon(Icons.person, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Welcome, ${authState.user.username}!",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      Column(
                        children: List<Widget>.generate(
                          products.length,
                          (index) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Detail(
                                    productId: products[index].id,
                                  ),
                                ),
                              );
                            },
                            child: ProductCard(
                              product: products[index],
                              onTap: () {
                                _showAddToCartDialog(context, products[index]);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (state is ProductStateInitial) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text("Loading products..."),
                    ],
                  ),
                );
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Failed to load products",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProductBloc>().add(ProductLoadEvent());
                      },
                      child: const Text("Try Again"),
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthStateAuthenticated) {
                return FloatingActionButton.extended(
                  onPressed: () {
                    _showCartComingSoon(context);
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("Cart"),
                  backgroundColor: Colors.blue,
                );
              }
              return FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("login");
                },
                icon: const Icon(Icons.login),
                label: const Text("Login"),
                backgroundColor: Colors.green,
              );
            },
          ),
        ),
      ),
    );
  }

  void _showAddToCartDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add to Cart"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.title ?? "Unknown Product",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text("Price: \$${product.price?.toStringAsFixed(2) ?? "0.00"}"),
            const SizedBox(height: 16),
            const Text("This feature will be available soon!"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showUserProfile(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("User Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileItem("Username", user.username),
            _buildProfileItem("Email", user.email),
            _buildProfileItem("User ID", user.id),
            const SizedBox(height: 16),
            const Text(
              "Cart functionality coming soon!",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value ?? "Not available"),
          ),
        ],
      ),
    );
  }

  void _showCartComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Shopping cart functionality coming in the next update!"),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
