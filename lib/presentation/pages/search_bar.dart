import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';

class TaskSearchBar extends StatelessWidget {
  const TaskSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: TextField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search by pattern (e.g. "meet")',
        ),
        onChanged: (value) => context.read<TaskBloc>().add(SearchTasks(value)),
      ),
    );
  }
}

