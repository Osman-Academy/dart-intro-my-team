import 'package:flutter/material.dart';
import 'package:navigation/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function()? onTap;
  const ProductCard({super.key, required this.product, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(product.thumbnail!),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Text(product.title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18)),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${product.price.toString()} USD",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                  ),
                  IconButton(
                      onPressed: onTap, icon: const Icon(Icons.shopping_basket))
                ],
              ),
            )
          ],
        ));
  }
}
