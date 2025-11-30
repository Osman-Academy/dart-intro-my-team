import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false).findById(productId)!;
    final cart = Provider.of<CartProvider>(context, listen: false);
    final isWide = MediaQuery.of(context).size.width >= 700;

    Widget imageSection = AspectRatio(
      aspectRatio: 4 / 3,
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.image_not_supported)),
      ),
    );

    Widget infoSection = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            product.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            product.brand,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber[600], size: 20),
              const SizedBox(width: 4),
              Text(product.rating.toStringAsFixed(1)),
              const SizedBox(width: 12),
              Text('В наличии: ${product.stock}'),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 16),
          Text(product.description),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    cart.add(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Добавлено в корзину')),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Добавить в корзину'),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(12)),
                onPressed: () => Navigator.of(context).pushNamed('/cart'),
                child: const Icon(Icons.shopping_cart),
              ),
            ],
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: imageSection),
                Expanded(child: SingleChildScrollView(child: infoSection)),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  imageSection,
                  infoSection,
                ],
              ),
            ),
    );
  }
}
