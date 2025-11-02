import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/cart/cart_bloc.dart';
import 'package:navigation/bloc/cart/cart_event.dart';
import 'package:navigation/bloc/cart/cart_state.dart';
import 'package:navigation/models/cart_item.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is CartLoaded) {
            if (state.totalItems == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined, 
                         size: 100, color: Colors.grey),
                    SizedBox(height: 20),
                    Text("Your cart is empty", 
                         style: TextStyle(fontSize: 20, color: Colors.grey)),
                  ],
                ),
              );
            }
            
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: _buildCategoryList(context, state),
                  ),
                ),
                
                _buildTotalPanel(context, state),
              ],
            );
          }
          
          return const SizedBox();
        },
      ),
    );
  }
  
  List<Widget> _buildCategoryList(BuildContext context, CartLoaded state) {
    List<Widget> widgets = [];
    
    state.itemsByCategory.forEach((categoryName, items) {
      widgets.add(
        Container(
          padding: EdgeInsets.all(12),
          color: Colors.grey[200],
          child: Text(
            categoryName.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      );
      
      for (var item in items) {
        widgets.add(_buildCartItem(context, item));
      }
    });
    
    return widgets;
  }
  
  Widget _buildCartItem(BuildContext context, CartItem item) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.product.thumbnail ?? '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: Icon(Icons.image),
                  );
                },
              ),
            ),
            
            SizedBox(width: 12),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.title ?? 'Product',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$${item.product.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: TextStyle(fontSize: 14, color: Colors.green),
                  ),
                ],
              ),
            ),
            
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        context.read<CartBloc>().add(
                          CartChangeQuantityEvent(
                            item.product.id!,
                            item.quantity - 1,
                          ),
                        );
                      },
                    ),
                    
                    Text(
                      '${item.quantity}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    
                    IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () {
                        context.read<CartBloc>().add(
                          CartChangeQuantityEvent(
                            item.product.id!,
                            item.quantity + 1,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                
                Text(
                  '\$${item.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTotalPanel(BuildContext context, CartLoaded state) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Products amount: ", style: TextStyle(fontSize: 16)),
              Text("${state.totalItems}", 
                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          
          SizedBox(height: 8),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total:", 
                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("\$${state.totalPrice.toStringAsFixed(2)}", 
                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, 
                                    color: Colors.green)),
            ],
          ),
          
          SizedBox(height: 12),
          
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Order is in processing")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text(
                "Place an order",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}