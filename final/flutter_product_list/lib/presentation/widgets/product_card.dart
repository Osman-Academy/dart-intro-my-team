import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(product.thumbnail, width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(product.brand, style: TextStyle(color: Colors.grey[600])),
        trailing: Text(
          '\$${product.price}',
          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}