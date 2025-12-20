import 'package:get_it/get_it.dart';
import 'data/datasources/dummy_data.dart';
import 'data/repositories/camera_repository_impl.dart';
import 'domain/repositories/camera_repository.dart';
import 'domain/usecases/get_cameras.dart';
import 'domain/usecases/search_cameras.dart';
import 'presentation/providers/camera_provider.dart';
import 'presentation/providers/cart_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Providers
  sl.registerFactory(
    () => CameraProvider(
      getCameras: sl(),
      searchCameras: sl(),
    ),
  );
  sl.registerFactory(() => CartProvider());

  // Use cases
  sl.registerLazySingleton(() => GetCameras(sl()));
  sl.registerLazySingleton(() => SearchCameras(sl()));

  // Repository
  sl.registerLazySingleton<CameraRepository>(
    () => CameraRepositoryImpl(),
  );
}
