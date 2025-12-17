import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';

class StudentRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  StudentRemoteDataSource({
    required this.client,
    required this.baseUrl,
  });

  Future<List<StudentModel>> fetchStudents() async {
    final uri = Uri.parse('$baseUrl/students');
    final resp = await client.get(uri, headers: {'Accept': 'application/json'});

    if (resp.statusCode == 200) {
      final decoded = json.decode(resp.body);
      if (decoded is List) {
        return decoded.map((e) => StudentModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load students: ${resp.statusCode}');
    }
  }
}