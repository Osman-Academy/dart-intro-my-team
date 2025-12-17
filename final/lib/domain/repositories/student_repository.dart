import '../entities/student.dart';

abstract class StudentRepository {
  Future<List<Student>> fetchStudents();

  Future<List<Student>> searchStudents(String query);
}