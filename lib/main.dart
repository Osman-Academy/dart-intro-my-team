import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/product_catalog/presentation/pages/product_page.dart';
import 'features/product_catalog/presentation/bloc/product_bloc.dart';
import 'injection_container.dart' as di;
import 'features/product_catalog/presentation/bloc/product_event.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => di.sl<ProductBloc>()..add(const ProductEvent.load()),
        child: const ProductPage(),
      ),
    );
  }
}

