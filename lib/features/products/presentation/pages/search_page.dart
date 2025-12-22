import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../data/models/product_model.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import '../bloc/products_state.dart';
import '../cubit/cart_cubit.dart';
import 'product_details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isWildcardPattern(String p) => p.contains('*') || p.contains('?');

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductsBloc>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F1F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.6,
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search products (pattern)…  (use * or ?)',
            border: InputBorder.none,
            suffixIcon: IconButton(
              tooltip: 'Clear',
              onPressed: () {
                _controller.clear();
                bloc.add(const ProductsSearchCleared());
                FocusScope.of(context).unfocus();
              },
              icon: const Icon(Icons.close, size: 20),
            ),
          ),
          onChanged: (v) => bloc.add(ProductsSearchChanged(v)),
        ),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          final items = state.filtered;

          if (items.isEmpty) {
            return const Center(
              child: Text('No matches', style: TextStyle(color: Colors.black54)),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final p = items[index];

              return _SearchTile(
                product: p,
                query: state.query,
                enableHighlight: !_isWildcardPattern(state.query.trim()),
              );
            },
          );
        },
      ),
    );
  }
}

class _SearchTile extends StatelessWidget {
  final ProductModel product;
  final String query;
  final bool enableHighlight;

  const _SearchTile({
    required this.product,
    required this.query,
    required this.enableHighlight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
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
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 12,
              offset: Offset(0, 8),
              color: Color(0x14000000),
            )
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _Thumb(url: product.imageUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HighlightedText(
                    text: product.title,
                    pattern: query,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                    enabled: enableHighlight,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black45, size: 20),
          ],
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  final String url;
  const _Thumb({required this.url});

  @override
  Widget build(BuildContext context) {
    final u = url.trim();

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 56,
        height: 56,
        child: u.isEmpty
            ? Container(
          color: const Color(0xFFF0E6E6),
          child: const Icon(Icons.broken_image_outlined,
              color: Colors.black54, size: 22),
        )
            : CachedNetworkImage(
          imageUrl: u,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            color: const Color(0xFFF0E6E6),
            child: const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
          errorWidget: (_, __, ___) => Container(
            color: const Color(0xFFF0E6E6),
            child: const Icon(Icons.broken_image_outlined,
                color: Colors.black54, size: 22),
          ),
        ),
      ),
    );
  }
}

class _HighlightedText extends StatelessWidget {
  final String text;
  final String pattern;
  final TextStyle style;
  final bool enabled;

  const _HighlightedText({
    required this.text,
    required this.pattern,
    required this.style,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final p = pattern.trim();
    if (p.isEmpty || !enabled) return Text(text, style: style);

    final lowerText = text.toLowerCase();
    final lowerP = p.toLowerCase();

    final start = lowerText.indexOf(lowerP);
    if (start < 0) return Text(text, style: style);

    final end = start + p.length;

    return RichText(
      text: TextSpan(
        style: style.copyWith(color: Colors.black),
        children: [
          TextSpan(text: text.substring(0, start)),
          TextSpan(
            text: text.substring(start, end),
            style: style.copyWith(backgroundColor: const Color(0xFFFFE082)),
          ),
          TextSpan(text: text.substring(end)),
        ],
      ),
    );
  }
}
