import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Shrinking Square',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DynamicSquarePage(),
    );
  }
}

class DynamicSquarePage extends StatefulWidget {
  const DynamicSquarePage({super.key});

  @override
  State<DynamicSquarePage> createState() => DynamicSquarePageState();
}

class DynamicSquarePageState extends State<DynamicSquarePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // repeat animation back and forth

    sizeAnimation = Tween<double>(begin: 200, end: 50).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic Shrinking Square')),
      body: Center(
        child: AnimatedBuilder(
          animation: sizeAnimation,
          builder: (context, child) {
            return Container(
              width: sizeAnimation.value,
              height: sizeAnimation.value,
              color: Colors.blue,
            );
          },
        ),
      ),
    );
  }
}
