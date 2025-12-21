import 'package:dio/dio.dart';
import 'package:final_project/repositories/video_repository.dart';
import 'package:final_project/repositories/video_repository_impl.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerSingleton(() => Dio());
  sl.registerSingleton<VideoRepository>(
    VideoRepositoryImpl(),
  );

}
