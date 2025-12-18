import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';

class TaskSearchBar extends StatelessWidget {
  const TaskSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search tasks...'),
        onChanged: (value) => context.read<TaskBloc>().add(SearchTasks(value)),
      ),
    );
  }
}

