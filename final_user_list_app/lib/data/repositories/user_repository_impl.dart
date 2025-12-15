// Data Layer - User Repository Implementation
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final userModels = await remoteDataSource.getUsers();
      final users = userModels.map((model) => model.toEntity()).toList();
      return Right(users);
    } on ServerException catch (e) {
      return Left(Failure.serverFailure(e.message));
    } on NetworkException catch (e) {
      return Left(Failure.networkFailure(e.message));
    } catch (e) {
      return Left(Failure.serverFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> getUserById(int id) async {
    try {
      final userModel = await remoteDataSource.getUserById(id);
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverFailure(e.message));
    } on NetworkException catch (e) {
      return Left(Failure.networkFailure(e.message));
    } catch (e) {
      return Left(Failure.serverFailure('Unexpected error: $e'));
    }
  }
}
