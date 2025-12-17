import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_finall_project/domain/entities/task.dart';
import 'package:flutter_application_finall_project/domain/entities/task_priority.dart';

/// Enhanced TaskItem widget that displays task information including priority and due date.
/// Shows title, description, priority badge, due date, and action buttons.
class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback? onToggleCompletion;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const TaskItem({
    super.key,
    required this.task,
    this.onToggleCompletion,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              // Checkbox
              Checkbox(
                value: task.completed,
                onChanged: (_) => onToggleCompletion?.call(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),

              // Expanded task info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            decoration: task.completed ? TextDecoration.lineThrough : null,
                            color: task.completed ? Colors.grey : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Description
                    if (task.description.isNotEmpty)
                      Text(
                        task.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade700,
                              decoration: task.completed ? TextDecoration.lineThrough : null,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),

                    // Tags row: Priority, Due date
                    Row(
                      children: [
                        // Priority badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getPriorityColor().withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            task.priority.displayName,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getPriorityColor(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Due date
                        if (task.dueDate != null)
                          Row(
                            children: [
                              Icon(
                                task.isOverdue ? Icons.warning_rounded : Icons.calendar_today,
                                size: 14,
                                color: task.isOverdue ? Colors.red : Colors.blue,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                DateFormat('MMM dd').format(task.dueDate!),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: task.isOverdue ? Colors.red : Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Delete button
              if (onDelete != null)
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: onDelete,
                  color: Colors.grey,
                )
              else
                const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (task.completed) {
      return Colors.green.shade50;
    }
    if (task.isOverdue) {
      return Colors.red.shade50;
    }
    return Colors.white;
  }

  Color _getPriorityColor() {
    switch (task.priority) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
    }
  }
}
