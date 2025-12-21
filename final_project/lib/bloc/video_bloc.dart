import 'package:final_project/bloc/video_event.dart';
import 'package:final_project/bloc/video_state.dart';
import 'package:final_project/repositories/video_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoRepositoryImpl repository = VideoRepositoryImpl();
  VideoBloc() : super(VideoStateInitial()) {
    on<VideoLoadEvent>((event, emit) async {
      var result = await repository.getVideos();
      emit(VideoStateSuccess(videos: result));
    });

    on<VideoViewEvent>((event, emit) async {
      emit(VideoStateLoading());
      var result = await repository.searchVideos(event.query);
      emit(VideoStateSuccess(videos : result));
    });
  }
}