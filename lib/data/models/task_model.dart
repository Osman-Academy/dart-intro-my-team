import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_application_finall_project/domain/entities/task.dart';
import 'package:flutter_application_finall_project/domain/entities/task_priority.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

/// Freezed data model for Task used by the data layer.
/// Fields: id, title, description, completed, priority, dueDate.
///
/// Example JSON from https://jsonplaceholder.typicode.com/todos:
/// {
///   "userId": 1,
///   "id": 1,
///   "title": "delectus aut autem",
///   "completed": false,
///   "priority": "medium",
///   "dueDate": "2024-12-25"
/// }
@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required int id,
    required String title,
    required String description,
    required bool completed,
    @Default('medium') String priority,
    @Default(null) String? dueDate,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}

extension TaskModelX on TaskModel {
  /// Convert the data model to the domain entity.
  Task toEntity() => Task(
        id: id,
        title: title,
        description: description,
        completed: completed,
        priority: TaskPriorityX.fromString(priority),
        dueDate: dueDate != null ? DateTime.tryParse(dueDate!) : null,
      );
}

extension TaskToModelX on Task {
  /// Convert the domain entity to the data model.
  TaskModel toModel() => TaskModel(
        id: id,
        title: title,
        description: description,
        completed: completed,
        priority: priority.toStringValue(),
        dueDate: dueDate?.toIso8601String().split('T')[0],
      );
}

// NOTE: Run `flutter pub run build_runner build --delete-conflicting-outputs`
// to generate the `task_model.freezed.dart` and `task_model.g.dart` files.
