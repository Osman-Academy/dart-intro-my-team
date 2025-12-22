import '../../models/auth_response_model.dart';
import 'api_client.dart';

class AuthRemoteDataSource {
  final ApiClient client;
  AuthRemoteDataSource(this.client);

  Future<AuthResponseModel> login(String email, String password) async {
    final res = await client.post('/auth/login', {'email': email, 'password': password});
    return AuthResponseModel.fromJson(res as Map<String, dynamic>);
  }

  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final res = await client.post('/auth/register', {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    });
    return AuthResponseModel.fromJson(res as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> me() async {
    final res = await client.get('/auth/me');
    return res as Map<String, dynamic>;
  }
}
