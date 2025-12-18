import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/products_bloc.dart';
import '../widgets/product_list_tile.dart';
import '../../../cart/presentation/widgets/cart_icon.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: const [
          CartIconButton(),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: _SearchBar(
              controller: _controller,
              onChanged: (value) => context
                  .read<ProductsBloc>()
                  .add(ProductsEvent.searchProducts(value)),
            ),
          ),
        ),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
              child: Text('Start by searching or loading products'),
            ),
            loading: (products) => products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : _ProductsList(products: products, isLoading: true),
            loadSuccess: (products) =>
                _ProductsList(products: products, isLoading: false),
            detailSuccess: (product) =>
                _ProductsList(products: [product], isLoading: false),
            searchSuccess: (products, query) => _ProductsList(
              products: products,
              isLoading: false,
              emptyLabel: 'No results for "$query"',
            ),
            failure: (message) => _ErrorView(message: message),
          );
        },
      ),
    );
  }
}

class _ProductsList extends StatelessWidget {
  const _ProductsList({
    required this.products,
    this.isLoading = false,
    this.emptyLabel = 'No products found',
  });

  final List<Product> products;
  final bool isLoading;
  final String emptyLabel;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      if (isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      return Center(child: Text(emptyLabel));
    }

    return Stack(
      children: [
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          itemCount: products.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) => ProductListTile(
            product: products[index],
            onAddToCart: () => context.read<CartBloc>().add(
                  CartEvent.add(product: products[index]),
                ),
          ),
        ),
        if (isLoading)
          const Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black12),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => context
                .read<ProductsBloc>()
                .add(const ProductsEvent.fetchProducts()),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search products...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}
