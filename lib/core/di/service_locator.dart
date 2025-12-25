import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/remote/api_client.dart';
import '../../data/datasources/remote/task_remote_data_source.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../data/services/token_storage.dart';
import '../constants/app_constants.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Async singletons
  sl.registerSingletonAsync<SharedPreferences>(SharedPreferences.getInstance);

  // Token storage depends on prefs
  sl.registerSingletonWithDependencies<TokenStorage>(
    () => TokenStorage(sl<SharedPreferences>()),
    dependsOn: [SharedPreferences],
  );

  // API client uses token storage for auth header
  sl.registerLazySingleton<ApiClient>(() => ApiClient(
        baseUrl: AppConstants.apiBaseUrl,
        tokenProvider: () => sl<TokenStorage>().getToken(),
      ));

  // Remote datasource and repository
  sl.registerLazySingleton<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImpl(sl<ApiClient>()));
  sl.registerLazySingleton<TaskRepositoryImpl>(
      () => TaskRepositoryImpl(remote: sl<TaskRemoteDataSource>()));
}
