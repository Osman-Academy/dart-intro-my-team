import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/products_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product #$productId'),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return state.when(
            initial: () =>
                const Center(child: CircularProgressIndicator()),
            loading: (_) =>
                const Center(child: CircularProgressIndicator()),
            loadSuccess: (products) {
              if (products.isEmpty) {
                return const Center(child: Text('Product not found'));
              }
              final product = products.firstWhere(
                (p) => p.id == productId,
                orElse: () => products.first,
              );
              return _DetailView(product: product);
            },
            detailSuccess: (product) => _DetailView(product: product),
            searchSuccess: (products, _) {
              if (products.isEmpty) {
                return const Center(child: Text('Product not found'));
              }
              return _DetailView(product: products.first);
            },
            failure: (message) => _Error(message: message, productId: productId),
          );
        },
      ),
    );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (product.thumbnail != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.thumbnail!,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported, size: 64),
            ),
          ),
        const SizedBox(height: 16),
        Text(
          product.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          '\$${product.price}',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        if (product.rating != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, size: 18, color: Colors.amber),
              const SizedBox(width: 4),
              Text(product.rating!.toString()),
            ],
          ),
        ],
        const SizedBox(height: 12),
        Text(product.description ?? 'No description'),
        const SizedBox(height: 20),
        Text('Brand: ${product.brand ?? 'N/A'}'),
        Text('Category: ${product.category ?? 'N/A'}'),
        if (product.stock != null) Text('Stock: ${product.stock}'),
        const SizedBox(height: 24),
        const Text(
          'Gallery',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (product.images != null && product.images!.isNotEmpty)
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: product.images!.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, index) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.images![index],
                  width: 140,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported),
                ),
              ),
            ),
          )
        else
          const Text('No images available'),
      ],
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({required this.message, required this.productId});

  final String message;
  final int productId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => context
                .read<ProductsBloc>()
                .add(ProductsEvent.fetchProduct(productId)),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
