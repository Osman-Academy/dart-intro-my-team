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

    // on<ProductEventView>((event, emit) async {
    //   emit(ProductStateLoading());
    //   var result =
    //   await repository.view(ProductDto(productId: event.productId));
    //   emit(ProductStateView(product: result));
    // });
  }
}