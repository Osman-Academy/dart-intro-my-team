import 'package:final_products_app/features/presentation/cubit/product_state.dart';
import 'package:final_products_app/features/presentation/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubitPage extends StatefulWidget {
  const ProductCubitPage({super.key});

  @override
  State<ProductCubitPage> createState() {
    return _ProductCubitPageState();
  }
}

class _ProductCubitPageState extends State<ProductCubitPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Products page"),),
      body:
        Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Search'),
              onChanged: (value) {
                context.read<ProductCubit>().searchProducts(value);
              },
            ),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
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
            )
          ],
        ) 
    );
  }
}
