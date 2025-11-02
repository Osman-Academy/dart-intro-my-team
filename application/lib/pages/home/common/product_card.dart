// lib/pages/home/common/product_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/cart_bloc.dart';
import 'package:navigation/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function()? onTap;
  
  const ProductCard({super.key, required this.product, this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image - КВАДРАТНОЕ ИЗОБРАЖЕНИЕ
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        product.thumbnail!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.image, size: 40, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                    
                    // ТОЛЬКО РЕЙТИНГ (дисконты убраны)
                    if (product.rating != null)
                      Positioned(
                        top: 6,
                        right: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 10),
                              const SizedBox(width: 2),
                              Text(
                                product.rating!.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              // Product Info
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category
                    if (product.category != null)
                      Text(
                        product.category!.toUpperCase(),
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    
                    const SizedBox(height: 4),
                    
                    // Title
                    Text(
                      product.title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 6),
                    
                    // Price and Cart Button
                    Row(
                      children: [
                        // Price (только основная цена)
                        Expanded(
                          child: Text(
                            '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.green,
                              height: 1.1,
                            ),
                          ),
                        ),
                        
                        // Add to Cart Button
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            bool isInCart = false;
                            if (state is CartLoadedState) {
                              isInCart = state.items.any((item) => item.product.id == product.id);
                            }
                            
                            return Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: isInCart ? Colors.green : Colors.blue,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: () {
                                  context.read<CartBloc>().add(CartAddItemEvent(product));
                                  
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product.title} added to cart'),
                                      duration: const Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  isInCart ? Icons.check : Icons.shopping_basket,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}