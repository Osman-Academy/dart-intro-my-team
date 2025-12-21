import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TaskBloc>()..add(const TaskEvent.load()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Task Manager')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                decoration: const InputDecoration(hintText: 'Search tasks...'),
                onChanged: (value) {
                  context.read<TaskBloc>().add(TaskEvent.search(value));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (_, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: state.filteredTasks.length,
                    itemBuilder: (_, index) {
                      final task = state.filteredTasks[index];
                      return ListTile(
                        title: Text(task.title),
                        trailing: Icon(
                          task.completed
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
