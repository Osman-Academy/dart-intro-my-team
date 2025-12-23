import 'package:dio/dio.dart';
import 'package:final_products_app/features/data/data_sources/dummyjson_product.dart';
import 'package:final_products_app/features/data/repository/product_repository_impl.dart';
import 'package:final_products_app/features/domain/repository/product_repository.dart';
import 'package:final_products_app/features/presentation/bloc/product_bloc.dart';
import 'package:final_products_app/features/presentation/bloc/product_event.dart';
import 'package:final_products_app/features/presentation/cubit/product_cubit.dart';
import 'package:final_products_app/features/presentation/screens/product_cubit_page.dart';
import 'package:final_products_app/features/presentation/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  final dio = Dio();

  final DummyProductRemoteDataSource dummyProductRemoteDataSource = DummyProductRemoteDataSource(dio);

  final ProductRepository productRepository = ProductRepositoryImpl(dummyProductRemoteDataSource);

  runApp(MyApp(productRepository: productRepository));
}

class MyApp extends StatelessWidget {
  final ProductRepository productRepository;

  const MyApp({super.key, required this.productRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        // create: (_) => ProductBloc(productRepository)..add(LoadProducts()),
        create: (_) => ProductCubit(productRepository)..getProducts(),
        child: ProductCubitPage(),
      ),
    );
  }
}