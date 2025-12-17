import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/utils/debouncer.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import '../bloc/products_state.dart';
import '../widgets/product_tile.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _debouncer = Debouncer();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductsBloc>()..add(const ProductsEvent.started()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Product Search'),
              actions: [
                IconButton(
                  tooltip: 'Refresh',
                  onPressed: () => context
                      .read<ProductsBloc>()
                      .add(const ProductsEvent.refreshed()),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search products (title / description)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _debouncer.run(() {
                        context
                            .read<ProductsBloc>()
                            .add(ProductsEvent.queryChanged(value));
                      });
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                      if (state.status == ProductsStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.status == ProductsStatus.failure) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.cloud_off, size: 56),
                                const SizedBox(height: 8),
                                Text(
                                  'Failed to load products',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.errorMessage ?? 'Unknown error',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                FilledButton(
                                  onPressed: () => context
                                      .read<ProductsBloc>()
                                      .add(const ProductsEvent.started()),
                                  child: const Text('Try again'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      final items = state.filtered;

                      if (items.isEmpty) {
                        return Center(
                          child: Text(
                            state.query.isEmpty
                                ? 'No products'
                                : 'No matches for: "${state.query}"',
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<ProductsBloc>()
                              .add(const ProductsEvent.refreshed());
                        },
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                          itemCount: items.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemBuilder: (context, i) =>
                              ProductTile(product: items[i]),
                        ),
                      );
                    },
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
