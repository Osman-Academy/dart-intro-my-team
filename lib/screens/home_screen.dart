import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<ProductProvider>();
    // Загружаем категории и товары после построения виджета
    Future.microtask(() async {
      await provider.loadCategories();
      await provider.loadProducts();
    });
  }

  int _getCrossAxisCount(double width) {
    if (width >= 1000) return 4;
    if (width >= 700) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final products = provider.filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final crossAxisCount = _getCrossAxisCount(width);

          if (provider.isLoading && products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null && products.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ошибка загрузки товаров',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      provider.errorMessage!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => provider.loadProducts(),
                      child: const Text('Повторить'),
                    )
                  ],
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Поиск по товарам',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: provider.applySearch,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.categories.length,
                    itemBuilder: (context, index) {
                      final category = provider.categories[index];
                      final isSelected = provider.selectedCategory == category;
                      return ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (_) {
                          provider.selectCategory(
                            isSelected ? null : category,
                          );
                        },
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: products.isEmpty
                      ? const Center(child: Text('Нет товаров'))
                      : GridView.builder(
                          itemCount: products.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 3 / 4,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (ctx, i) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ProductDetailScreen(
                                  productId: products[i].id,
                                ),
                              ));
                            },
                            child: ProductCard(product: products[i]),
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
