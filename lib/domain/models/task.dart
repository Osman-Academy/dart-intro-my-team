import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

/// Freezed data class representing a Task in the domain layer.
///
/// Fields:
/// - `id`: numeric identifier of the task
/// - `title`: short title of the task
/// - `description`: longer description (can be empty)
/// - `completed`: completion flag
@freezed
class Task with _$Task {
  const factory Task({
    required int id,
    required String title,
    required String description,
    required bool completed,
  }) = _Task;

  /// JSON (de)serialization factory. Freezed + json_serializable will
  /// generate the implementation in `task.g.dart`.
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

/*
Example JSON response from the server (jsonplaceholder.typicode.com/todos):

[
  {
    "userId": 1,
    "id": 1,
    "title": "delectus aut autem",
    "completed": false
  },
  {
    "userId": 1,
    "id": 2,
    "title": "quis ut nam facilis et officia qui",
    "completed": false
  }
]

Note: The JSONPlaceholder `todos` endpoint does not provide a `description`
field. In our `Task` model we include `description`; when mapping JSON from
that endpoint you can set `description` to an empty string or derive it from
`title` (example mapping will be implemented in the DataSource). The fields
we care about from that endpoint are `id`, `title`, and `completed`.
*/
