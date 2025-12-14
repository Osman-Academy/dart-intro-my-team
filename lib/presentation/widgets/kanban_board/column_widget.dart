import 'package:flutter/material.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/entities/task_status.dart';
import 'task_card.dart';

class ColumnWidget extends StatelessWidget {
  final TaskStatus status;
  final List<TaskEntity> tasks;
  final void Function(String taskId, TaskStatus newStatus) onMove;
  const ColumnWidget({super.key, required this.status, required this.tasks, required this.onMove});

  String get _title {
    switch (status) {
      case TaskStatus.todo:
        return 'To Do';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.done:
        return 'Done';
    }
  }

  Color get _color {
    switch (status) {
      case TaskStatus.todo:
        return Colors.indigo.shade100;
      case TaskStatus.inProgress:
        return Colors.amber.shade100;
      case TaskStatus.done:
        return Colors.green.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _color.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${tasks.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...tasks.map(
            (task) => Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TaskCard(
                task: task,
                onMove: (newStatus) => onMove(task.id, newStatus),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
