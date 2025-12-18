import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/product_detail_page.dart';
import '../bloc/products_bloc.dart';
import '../../../../injection.dart';
import '../../domain/entities/product.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    super.key,
    required this.product,
    this.onAddToCart,
  });

  final Product product;
  final VoidCallback? onAddToCart;

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
      trailing: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100), // Adjust height as needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
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
            if (onAddToCart != null)
              IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: onAddToCart,
                tooltip: 'Add to cart',
              ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) =>
                  sl<ProductsBloc>()..add(ProductsEvent.fetchProduct(product.id)),
              child: ProductDetailPage(productId: product.id),
            ),
          ),
        );
      },
    );
  }
}
