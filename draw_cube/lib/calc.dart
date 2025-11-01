import 'package:flutter/material.dart';
import 'cube_painter.dart';

class Calc extends StatefulWidget {
  const Calc({super.key});

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> with SingleTickerProviderStateMixin {
  final TextEditingController controllerA = TextEditingController();
  final TextEditingController controllerB = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _animation;

  double currentSum = 0; 
  double targetSum = 0; 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _animation = Tween<double>(begin: currentSum, end: targetSum).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    controllerA.dispose();
    controllerB.dispose();
    super.dispose();
  }

  void _updateSum(double newSum) {
    _animation = Tween<double>(begin: currentSum, end: newSum).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward(from: 0); 
    currentSum = newSum; 
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Enter lengths A and B:",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: 200,
            child: TextFormField(
              controller: controllerA,
              decoration: const InputDecoration(
                labelText: "A",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 15),

          // Input B
          SizedBox(
            width: 200,
            child: TextFormField(
              controller: controllerB,
              decoration: const InputDecoration(
                labelText: "B",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 20),

          // Button
          ElevatedButton(
            onPressed: () {
              final a = double.tryParse(controllerA.text) ?? 0;
              final b = double.tryParse(controllerB.text) ?? 0;
              _updateSum(a + b);
            },
            child: const Text("Add and Draw Cube"),
          ),
          const SizedBox(height: 20),

          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Text(
                "Sum (cube side) = ${_animation.value.toStringAsFixed(1)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),

          const SizedBox(height: 30),

          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(_animation.value * 10, _animation.value * 10),
                painter: CubePainter(_animation.value),
              );
            },
          ),
        ],
      ),
    );
  }
}
