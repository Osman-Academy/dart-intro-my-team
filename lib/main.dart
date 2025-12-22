import 'package:flutter/material.dart';
import 'core/di/di.dart';
import 'features/products/presentation/pages/catalog_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  runApp(const CtApp());
}

class CtApp extends StatelessWidget {
  const CtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CT Makeup Catalog',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB76E79)),
      ),
      home: const CatalogPage(),
    );
  }
}
