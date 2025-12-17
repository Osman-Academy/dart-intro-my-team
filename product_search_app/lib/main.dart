import 'package:flutter/material.dart';
import 'core/di/injection.dart' as di;
import 'features/products/presentation/pages/products_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.configureDependencies();
  runApp(const ProductSearchApp());
}

class ProductSearchApp extends StatelessWidget {
  const ProductSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Search',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ProductsPage(),
    );
  }
}
