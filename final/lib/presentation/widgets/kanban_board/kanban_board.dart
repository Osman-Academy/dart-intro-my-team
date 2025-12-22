import 'package:flutter/material.dart';

import '../../../domain/entities/task_entity.dart';
import '../../../domain/entities/task_status.dart';
import 'column_widget.dart';

class KanbanBoard extends StatelessWidget {
  final List<TaskEntity> tasks;
  final void Function(String taskId, TaskStatus newStatus) onMove;
  const KanbanBoard({super.key, required this.tasks, required this.onMove});

  @override
  Widget build(BuildContext context) {
    final columns = TaskStatus.values;
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columns
              .map(
                (status) => Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: SizedBox(
                    width: 320,
                    child: ColumnWidget(
                      status: status,
                      tasks: tasks.where((t) => t.status == status).toList(),
                      onMove: onMove,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
