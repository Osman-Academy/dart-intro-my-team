import '../../domain/entities/task_entity.dart';
import '../../domain/entities/task_status.dart';
<<<<<<< HEAD
=======
import '../../domain/entities/user_entity.dart';
>>>>>>> 4ccf46f (Updated data folder, added mappers, models, repositories, api's, and datasources.)
import 'user_model.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final TaskStatus status;
  final String projectId;
  final UserModel? assignee;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.projectId,
    this.assignee,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      status: TaskStatus.values.firstWhere(
        (e) => e.name == (json['status'] as String).toLowerCase(),
        orElse: () => TaskStatus.todo,
      ),
      projectId: json['projectId'] as String,
      assignee: json['assignee'] != null
          ? UserModel.fromJson(json['assignee'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.name.toUpperCase(),
      'projectId': projectId,
      'assignee': assignee?.toJson(),
    };
  }

  TaskEntity toEntity() => TaskEntity(
        id: id,
        title: title,
        description: description,
        status: status,
        projectId: projectId,
        assignee: assignee?.toEntity(),
      );

  static TaskModel fromEntity(TaskEntity entity) => TaskModel(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        status: entity.status,
        projectId: entity.projectId,
        assignee: entity.assignee != null
            ? UserModel.fromEntity(entity.assignee!)
            : null,
      );
}
