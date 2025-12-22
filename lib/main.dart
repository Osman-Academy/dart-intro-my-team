<<<<<<< HEAD
import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        // useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      // A widget which will be started on application startup
      home: MyHomePage(title: 'Flutter Demo Home Page'),
=======
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/product/product_cubit.dart';
import 'bloc/product/product_state.dart';
import 'data/product_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => ProductCubit(ProductRepository()),
        child: const ProductPage(),
      ),
>>>>>>> 5681d64 (Initial Flutter product search app)
    );
  }
}

<<<<<<< HEAD
class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});
=======
class ProductPage extends StatelessWidget {
  const ProductPage({super.key});
>>>>>>> 5681d64 (Initial Flutter product search app)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text(title),
      ),
      body: Center(
        child: Container(
            child: CustomPaint(
          painter: DrawingPainter(),
          size: Size.infinite,
        )),
=======
      appBar: AppBar(title: const Text('Products')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search product...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<ProductCubit>().search(value);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = state.filteredProducts[index];
                    return ListTile(
                      leading: Text(product.id.toString()),
                      title: Text(product.title),
                    );
                  },
                );
              },
            ),
          ),
        ],
>>>>>>> 5681d64 (Initial Flutter product search app)
      ),
    );
  }
}
<<<<<<< HEAD

class DrawingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..addRect(Rect.fromPoints(Offset(80, 80), Offset(70, 70)));

    for (int i = 80; i < 360; i++) {
      path.moveTo(i.toDouble(), i.toDouble());
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
=======
>>>>>>> 5681d64 (Initial Flutter product search app)
