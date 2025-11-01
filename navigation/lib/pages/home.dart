import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/bloc/product_bloc.dart';
import 'package:navigation/bloc/product_event.dart';
import 'package:navigation/bloc/product_state.dart';
import 'package:navigation/models/product.dart';
import 'package:navigation/pages/detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Product> products = [];
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: const Text("Products")),
          body:
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is ProductStateSuccess) {
              products = state.products;
            }
            return SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List<Widget>.generate(
                    products.length,
                    (index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Detail(
                                    productId: products[index].id,
                                  )));
                        },
                        child: Column(
                          children: [
                            Image.network(products[index].thumbnail!),
                            Text(products[index].title!)
                          ],
                        )),
                  )),
            );
          })),
    );
  }
}
