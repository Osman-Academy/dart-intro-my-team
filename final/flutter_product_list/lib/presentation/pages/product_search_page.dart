import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection_container.dart';
import '../bloc/product_bloc.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar_widget.dart';

class ProductSearchPage extends StatelessWidget {
  const ProductSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Product Explorer')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return SearchBarWidget(
                    onChanged: (val) => context.read<ProductBloc>().add(ProductEvent.searchChanged(val)),
                  );
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const Center(child: Text('Start typing to find products!')),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (msg) => Center(child: Text(msg, style: const TextStyle(color: Colors.red))),
                      loaded: (products) => products.isEmpty
                          ? const Center(child: Text('No products found.'))
                          : ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (context, index) => ProductCard(product: products[index]),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}