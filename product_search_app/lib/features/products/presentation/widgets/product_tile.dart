import 'package:flutter/material.dart';
import '../../products.dart';


class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            product.image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const ColoredBox(
              color: Colors.black12,
              child: Center(child: Icon(Icons.image_not_supported)),
            ),
          ),
        ),
        title: Text(
          product.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          product.category,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            builder: (_) => Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${product.price.toStringAsFixed(2)} • ${product.category}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.image,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(product.description),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
