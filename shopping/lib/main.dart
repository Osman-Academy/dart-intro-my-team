import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/products/presentation/bloc/products_bloc.dart';
import 'features/products/presentation/pages/product_detail_page.dart';
import 'features/products/presentation/pages/products_page.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/cart/presentation/pages/cart_page.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                sl<ProductsBloc>()..add(const ProductsEvent.fetchProducts()),
          ),
          BlocProvider(
            create: (_) => sl<CartBloc>(),
          ),
        ],
        child: const ProductsPage(),
      ),
      onGenerateRoute: (settings) {
        final name = settings.name ?? '';
        if (name.startsWith('/product/')) {
          final idString = name.replaceFirst('/product/', '');
          final id = int.tryParse(idString);
          if (id != null) {
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) =>
                        sl<ProductsBloc>()..add(ProductsEvent.fetchProduct(id)),
                  ),
                  BlocProvider(
                    create: (_) => sl<CartBloc>(),
                  ),
                ],
                child: ProductDetailPage(productId: id),
              ),
            );
          }
        }
        if (name == '/cart') {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) => sl<CartBloc>()..add(const CartEvent.load()),
              child: const CartPage(),
            ),
          );
        }
        return null;
      },
    );
  }
}
