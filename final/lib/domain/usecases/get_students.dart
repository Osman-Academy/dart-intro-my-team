import '../entities/student.dart';
import '../repositories/student_repository.dart';

class GetStudentsUseCase {
  final StudentRepository repository;

  GetStudentsUseCase(this.repository);

  Future<List<Student>> call({String? query}) async {
    if (query == null || query.trim().isEmpty) {
      return repository.fetchStudents();
    } else {
      return repository.searchStudents(query.trim());
    }
  }
}