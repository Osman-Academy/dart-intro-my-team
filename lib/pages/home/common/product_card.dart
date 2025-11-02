import 'package:flutter/material.dart';
import 'package:navigation/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function()? onTap;
  final Function()? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Center(
              child: Image.network(
                product.thumbnail ?? '',
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.shopping_bag, size: 50),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.all(8),
              child: Text(
                product.title ?? 'Unknown Product',
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Expanded(
                    child: Text(
                      "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onAddToCart,
                  icon: const Icon(Icons.shopping_basket),
                  tooltip: 'Add to cart',
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
