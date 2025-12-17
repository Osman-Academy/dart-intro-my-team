import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: product.thumbnail != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.thumbnail!,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
              ),
            )
          : const Icon(Icons.inventory_2_outlined, size: 32),
      title: Text(product.title),
      subtitle: Text(
        product.description ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$${product.price}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (product.rating != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                Text(product.rating!.toString()),
              ],
            ),
        ],
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/product/${product.id}',
          arguments: product.id,
        );
      },
    );
  }
}
