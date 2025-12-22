import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../data/models/product_model.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import '../bloc/products_state.dart';
import '../cubit/cart_cubit.dart';
import 'cart_page.dart';
import 'product_details_page.dart';
import 'search_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  static const categories = ['FACE', 'CHEEK', 'EYES', 'LIPS'];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<ProductsBloc>()..add(const ProductsRequested()),
        ),
        BlocProvider(
          create: (_) => sl<CartCubit>(),
        ),
      ],
      child: DefaultTabController(
        length: categories.length,
        child: Builder(
          builder: (innerContext) => Scaffold(
            backgroundColor: const Color(0xFFF7F1F1),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.6,
              titleSpacing: 16,
              title: const Text(
                'Charlotte Tilbury',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                  tooltip: 'Search',
                  onPressed: () {
                    Navigator.of(innerContext).push(
                      MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: innerContext.read<ProductsBloc>(),
                            ),
                            BlocProvider.value(
                              value: innerContext.read<CartCubit>(),
                            ),
                          ],
                          child: const SearchPage(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search, color: Colors.black),
                ),
                BlocBuilder<CartCubit, dynamic>(
                  builder: (context, state) {
                    final count = context.read<CartCubit>().state.totalItems;
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        IconButton(
                          tooltip: 'Bag',
                          onPressed: () {
                            Navigator.of(innerContext).push(
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: innerContext.read<CartCubit>(),
                                  child: const CartPage(),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.shopping_bag_outlined,
                              color: Colors.black),
                        ),
                        if (count > 0)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                '$count',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(width: 6),
              ],
              bottom: const TabBar(
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black54,
                indicatorColor: Colors.black,
                indicatorWeight: 2,
                tabs: [
                  Tab(text: 'FACE'),
                  Tab(text: 'CHEEK'),
                  Tab(text: 'EYES'),
                  Tab(text: 'LIPS'),
                ],
              ),
            ),
            body: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.error != null) {
                  return Center(
                    child: Text(
                      'Error: ${state.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                return TabBarView(
                  children: [
                    _ProductsGrid(category: 'FACE', products: state.products),
                    _ProductsGrid(category: 'CHEEK', products: state.products),
                    _ProductsGrid(category: 'EYES', products: state.products),
                    _ProductsGrid(category: 'LIPS', products: state.products),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductsGrid extends StatelessWidget {
  final String category;
  final List<ProductModel> products;

  const _ProductsGrid({
    required this.category,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final items = products.where((p) => p.category == category).toList();

    if (items.isEmpty) {
      return Center(
        child: Text(
          'No products in $category',
          style: const TextStyle(color: Colors.black54),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(14),
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, index) {
          final p = items[index];
          return _ProductCard(product: p);
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;

  const _ProductCard({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartCubit>();

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.read<CartCubit>(),
              child: ProductDetailsPage(product: product),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              blurRadius: 14,
              offset: Offset(0, 8),
              color: Color(0x14000000),
            )
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    color: const Color(0xFFF0E6E6),
                    child: const Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                        size: 46,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              product.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cart.add(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added: ${product.title}')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Add to bag'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
