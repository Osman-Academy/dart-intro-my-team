// presentation/pages/product_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: Column(
        children: [
          // TextField(
          //   decoration: InputDecoration(hintText: 'Search'),
          //   onChanged: (value) {
          //     context.read<ProductBloc>().add(SearchProducts(value));
          //   },
          // ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (_, index) {
                      final product = state.products[index];
                      return ListTile(
                        title: Text(product.title),
                        subtitle: Text(product.description),
                        trailing: Text('\$${product.price}'),
                        leading: Image.network(product.thumbnail),
                      );
                    },
                  );
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
