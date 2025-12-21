import 'package:final_project/repositories/video_repository.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerSingleton<VideoRepository>(
    VideoRepositoryImpl(),
    signalsReady: true,
  );
}
