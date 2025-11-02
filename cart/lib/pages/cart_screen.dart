// lib/pages/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isExpanded = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          IconButton(
            icon: Icon(_isExpanded ? Icons.zoom_out_map : Icons.zoom_in_map),
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartInitialState || 
              (state is CartLoadedState && state.items.isEmpty)) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Your cart is empty', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
          
          if (state is CartLoadedState) {
            return Column(
              children: [
                // Header with total
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Items: ${state.totalItems}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Total Price: \$${state.totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear_all),
                          onPressed: () {
                            _showClearCartDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Упрощенная версия без анимации
                Expanded(
                  child: _isExpanded 
                      ? ListView.builder(
                          itemCount: state.categories.length,
                          itemBuilder: (context, categoryIndex) {
                            final category = state.categories[categoryIndex];
                            return _buildCategorySection(category, context);
                          },
                        )
                      : Container(
                          padding: const EdgeInsets.all(16),
                          child: const Text(
                            'Cart content is minimized',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                ),
              ],
            );
          }
          
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
  
  Widget _buildCategorySection(CartCategory category, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Row(
              children: [
                Text(
                  category.categoryName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${category.categoryTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          
          // Items in category
          ...category.items.map((item) => _buildCartItem(item, context)),
        ],
      ),
    );
  }
  
  Widget _buildCartItem(CartItem item, BuildContext context) {
    return ListTile(
      leading: Image.network(
        item.product.thumbnail!,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(
        item.product.title!,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('\$${item.product.price?.toStringAsFixed(2)} each'),
          Text(
            'Total: \$${item.totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 20),
            onPressed: () {
              if (item.quantity > 1) {
                context.read<CartBloc>().add(
                  CartUpdateQuantityEvent(item.product, item.quantity - 1)
                );
              } else {
                context.read<CartBloc>().add(CartRemoveItemEvent(item.product));
              }
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${item.quantity}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 20),
            onPressed: () {
              context.read<CartBloc>().add(
                CartUpdateQuantityEvent(item.product, item.quantity + 1)
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red, size: 20),
            onPressed: () {
              context.read<CartBloc>().add(CartRemoveItemEvent(item.product));
            },
          ),
        ],
      ),
    );
  }
  
  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Are you sure you want to clear your entire cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(CartClearEvent());
              Navigator.of(context).pop();
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}