import 'package:equatable/equatable.dart';
import 'package:flutter_application_finall_project/domain/entities/task_priority.dart';

/// Domain entity representing a Task in the application core.
/// This is independent from the data layer (models/serializable classes).
class Task extends Equatable {
  final int id;
  final String title;
  final String description;
  final bool completed;
  final TaskPriority priority;
  final DateTime? dueDate;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    this.priority = TaskPriority.medium,
    this.dueDate,
  });

  /// Returns true if the task is overdue (due date is in the past).
  bool get isOverdue {
    if (dueDate == null || completed) return false;
    return dueDate!.isBefore(DateTime.now());
  }

  /// Returns true if the task is due today.
  bool get isDueToday {
    if (dueDate == null) return false;
    final now = DateTime.now();
    return dueDate!.year == now.year &&
        dueDate!.month == now.month &&
        dueDate!.day == now.day;
  }

  @override
  List<Object?> get props => [id, title, description, completed, priority, dueDate];
}
