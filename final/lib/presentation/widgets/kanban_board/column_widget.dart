import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          Expanded(
            child: DragTarget<TaskEntity>(
              onWillAccept: (task) => task != null && task.status != status,
              onAccept: (task) => onMove(task.id, status),
              builder: (context, candidateData, rejectedData) {
                final isActive = candidateData.isNotEmpty;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white.withOpacity(0.4) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: isActive ? Border.all(color: Colors.black26) : null,
                  ),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: tasks.isEmpty
                            ? [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    isActive ? 'Отпустите здесь' : 'Перетащите карточку сюда',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ]
                            : tasks
                                .map(
                                  (task) => Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: Draggable<TaskEntity>(
                                      data: task,
                                      feedback: Material(
                                        color: Colors.transparent,
                                        child: SizedBox(
                                          width: 280,
                                          child: TaskCard(task: task, isDragging: true),
                                        ),
                                      ),
                                      childWhenDragging: Opacity(
                                        opacity: 0.35,
                                        child: TaskCard(task: task),
                                      ),
                                      child: TaskCard(task: task),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
