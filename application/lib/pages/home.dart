// lib/pages/home.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/product_bloc.dart';
import 'package:navigation/bloc/product_event.dart';
import 'package:navigation/bloc/product_state.dart';
import 'package:navigation/bloc/cart_bloc.dart';
import 'package:navigation/models/product.dart';
import 'package:navigation/pages/detail.dart';
import 'package:navigation/pages/home/common/product_card.dart';
import 'package:navigation/pages/cart_screen.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int itemCount = 0;
              if (state is CartLoadedState) {
                itemCount = state.totalItems;
              }
              
              return Stack(
                children: [
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.shopping_cart, color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const CartScreen())
                      );
                    },
                  ),
                  if (itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          itemCount > 99 ? '99+' : itemCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProductStateSuccess) {
            products = state.products;
          }
          
          if (state is ProductStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          if (products.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No products available', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
          
          // GridView с 3 КАРТОЧКАМИ В РЯД
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 КАРТОЧКИ В РЯД
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7, // ОПТИМАЛЬНОЕ СООТНОШЕНИЕ
            ),
            itemCount: products.length,
            itemBuilder: (context, index) => ProductCard(
              product: products[index],
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Detail(productId: products[index].id)
                ));
              },
            ),
          );
        },
      ),
    );
  }
}