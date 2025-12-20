import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/task.dart';

part 'task_event.freezed.dart';

@freezed
class TaskEvent with _$TaskEvent {
  const factory TaskEvent.load() = _Load;
  const factory TaskEvent.search(String query) = _Search;

  const factory TaskEvent.add(String title) = _Add;
  const factory TaskEvent.edit(Task task) = _Edit;
  const factory TaskEvent.delete(String id) = _Delete;
  const factory TaskEvent.toggle(String id) = _Toggle;
}
