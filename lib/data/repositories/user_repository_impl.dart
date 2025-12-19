
import 'package:injectable/injectable.dart';
import 'package:string_search_app/data/datasource/user_remote_datasource.dart';
import 'package:string_search_app/data/models/user_model.dart';
import 'package:string_search_app/domain/entities/user.dart';
import 'package:string_search_app/domain/repositories/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<List<User>> getUsers() async {
    final models = await dataSource.fetchUsers();
    return models.map((model) => model.toEntity()).toList();
  }
}