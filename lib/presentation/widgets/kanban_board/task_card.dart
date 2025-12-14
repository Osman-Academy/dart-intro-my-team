import 'package:flutter/material.dart';

import '../../../domain/entities/task_entity.dart';
import '../../../domain/entities/task_status.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final void Function(TaskStatus status) onMove;
  const TaskCard({super.key, required this.task, required this.onMove});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: TaskStatus.values
                  .where((s) => s != task.status)
                  .map(
                    (status) => ActionChip(
                      label: Text(status.name.toUpperCase()),
                      onPressed: () => onMove(status),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
