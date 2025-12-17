import 'package:flutter_application_1/data/models/student_model.dart';

import '../../domain/entities/student.dart';
import '../../domain/repositories/student_repository.dart';
import '../datasources/student_remote_data_source.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentRemoteDataSource remoteDataSource;

  StudentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Student>> fetchStudents() async {
    final models = await remoteDataSource.fetchStudents();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Student>> searchStudents(String query) async {
    final all = await fetchStudents();
    final q = query.toLowerCase();
    return all.where((s) => s.name.toLowerCase().contains(q)).toList();
  }
}