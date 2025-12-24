
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:string_search_app/data/models/user_model.dart';

@lazySingleton
class UserRemoteDataSource {
  final Dio dio = Dio();

  Future<List<UserModel>> fetchUsers() async {
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/users');

    return (response.data as List)
        .map((e) => UserModel.fromJson(e))
        .toList();
  }
}
