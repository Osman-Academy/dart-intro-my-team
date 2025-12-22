import 'package:flutter/material.dart';

import '../../../domain/entities/task_entity.dart';
import '../../../domain/entities/task_status.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final bool isDragging;
  const TaskCard({super.key, required this.task, this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isDragging ? 6 : 2,
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
          ],
        ),
      ),
    );
  }
}
