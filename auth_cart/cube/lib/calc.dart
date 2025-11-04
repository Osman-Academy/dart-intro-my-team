import 'package:cube_visualizer/sub_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Начальная анимация с нулевым значением
    _animation = Tween<double>(begin: 0, end: 0).animate(
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

  void _updateAnimation(double newSum) {
    final currentValue = _animation.value;
    _animation = Tween<double>(begin: currentValue, end: newSum).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SumCubit, double>(
      listener: (context, sum) {
        // Обновляем анимацию когда меняется состояние Cubit
        _updateAnimation(sum);
      },
      child: Center(
        child: BlocBuilder<SumCubit, double>(
          builder: (context, sum) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Enter lengths A and B:",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Input A
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

                // Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final a = double.tryParse(controllerA.text) ?? 0;
                        final b = double.tryParse(controllerB.text) ?? 0;
                        context.read<SumCubit>().add(a, b);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Add"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: sum > 0
                          ? () {
                              context.read<SumCubit>().shrink();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Shrink"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        controllerA.clear();
                        controllerB.clear();
                        context.read<SumCubit>().reset();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Reset"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Animated Sum Display
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Cube Properties",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Side length = ${_animation.value.toStringAsFixed(1)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Visual size: ${(_animation.value * 10).toStringAsFixed(0)}×${(_animation.value * 10).toStringAsFixed(0)} px",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),

                // Animated Cube
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Column(
                      children: [
                        const Text(
                          "3D Cube Visualization:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CustomPaint(
                            size: Size(
                                _animation.value * 10, _animation.value * 10),
                            painter: CubePainter(_animation.value),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // Size indicators
                const SizedBox(height: 20),
                if (sum > 0) _buildSizeIndicators(sum),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSizeIndicators(double currentSize) {
    return Column(
      children: [
        const Text(
          "Size Scale:",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSizeIndicator("Small", 2, currentSize),
            _buildSizeIndicator("Medium", 5, currentSize),
            _buildSizeIndicator("Large", 8, currentSize),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeIndicator(
      String label, double targetSize, double currentSize) {
    final isActive = currentSize >= targetSize;
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.green : Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }
}
