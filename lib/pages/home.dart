import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/product/product_bloc.dart';
import 'package:navigation/bloc/product/product_event.dart';
import 'package:navigation/bloc/product/product_state.dart';
import 'package:navigation/models/product.dart';
import 'package:navigation/pages/detail.dart';
import 'package:navigation/pages/cart.dart';
import 'package:navigation/widgets/dynamic_square.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Product> products = [];
  double _iconSize = 120.0;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
          actions: [
            IconButton(
              icon: Icon(Icons.tune),
              onPressed: () async {
                final newSize = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DynamicIcon(initialSize: _iconSize)),
                );
                if (newSize != null) {
                  setState(() {
                    _iconSize = newSize;
                  });
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cart()),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductStateSuccess) {
              products = state.products;
            }

            return products.isEmpty
                ? Center(child: CircularProgressIndicator())
                : _buildProductGrid();
          },
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    int crossAxisCount = MediaQuery.of(context).size.width ~/ (_iconSize + 20);
    crossAxisCount =
        crossAxisCount.clamp(2, 4);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildProductCard(products[index]);
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    final cardWidth = _iconSize;
    final imageSize = cardWidth - 20;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Detail(productId: product.id),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: cardWidth,
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(product.thumbnail ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 8),

              Expanded(
                child: Text(
                  product.title ?? 'No title',
                  style: TextStyle(
                    fontSize: _calculateFontSize(cardWidth),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 4),

              Text(
                '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                style: TextStyle(
                  fontSize: _calculateFontSize(cardWidth) - 2,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateFontSize(double cardWidth) {
    return cardWidth * 0.09;
  }
}
