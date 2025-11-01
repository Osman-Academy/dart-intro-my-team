import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'radius_cubit.dart';

class Calc extends StatelessWidget {
  const Calc({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Form(
      child: BlocBuilder<RadiusCubit, double>(builder: (context, size) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Enter side length"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final value = double.tryParse(controller.text) ?? 0;
                  context.read<RadiusCubit>().update(value);
                },
                child: const Text("Shrink Square"),
              ),
              const SizedBox(height: 20),
              Container(
                width: size,
                height: size,
                color: Colors.blue,
              ),
              const SizedBox(height: 10),
              Text("Area: ${size * size}"),
            ],
          ),
        );
      }),
    );
  }
}
