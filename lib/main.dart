import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/product/product_cubit.dart';
import 'bloc/product/product_state.dart';
import 'data/product_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => ProductCubit(ProductRepository()),
        child: const ProductPage(),
      ),
    );
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              key: const Key('searchField'),
              decoration: const InputDecoration(
                hintText: 'Search product...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<ProductCubit>().search(value);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                final products = state.filteredProducts;
                if (products.isEmpty) {
                  return const Center(child: Text('No products'));
                }
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: Text(product.id.toString()),
                      title: Text(product.title),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
