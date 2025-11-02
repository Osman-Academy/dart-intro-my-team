import 'package:flutter/material.dart';
import 'package:navigation/bloc/product/product_bloc.dart';
import 'package:navigation/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/product/product_event.dart';
import 'package:navigation/bloc/product/product_state.dart';
import 'package:navigation/bloc/cart/cart_bloc.dart';
import 'package:navigation/bloc/cart/cart_event.dart';

class Detail extends StatefulWidget {
  int? productId;
  Detail({this.productId});
  @override
  State<Detail> createState() => DetailState();
}

class DetailState extends State<Detail> {
  Product? product;
  @override
  void initState() {
    super.initState();
    context
        .read<ProductBloc>()
        .add(ProductEventView(productId: widget.productId!));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductStateLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is ProductStateView) {
          product = state.product;
          return Scaffold(
            appBar: AppBar(
              title: Text("Product detail"),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.network(product!.thumbnail!),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Text(product!.title!)),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.red,
                      ),
                      Expanded(child: Text(product!.rating.toString())),
                      Text(product!.price.toString() + " USD")
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text("Добавить в корзину"),
                      onPressed: () {
                        context.read<CartBloc>().add(CartAddEvent(product!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Товар добавлен в корзину!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    ));
  }
}
