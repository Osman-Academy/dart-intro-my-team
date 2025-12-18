import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (products) => ListView.builder(
              itemCount: products.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(products[i].title),
                trailing: Text('\$${products[i].price}'),
              ),
            ),
            error: (msg) => Center(child: Text(msg)),
          );
        },
      ),
    );
  }
}

