import 'package:final_project/bloc/video_bloc.dart';
import 'package:final_project/bloc/video_event.dart';
import 'package:final_project/bloc/video_state.dart';
import 'package:final_project/entities/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Detail extends StatefulWidget {
  String? query;
  Detail({this.query});
  @override
  State<Detail> createState() => DetailState();
}

class DetailState extends State<Detail> {
  List<Video>? videos;
  @override
  void initState() {
    super.initState();
    context
        .read<VideoBloc>()
        .add(VideoViewEvent(query: widget.query!));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        if (state is VideoStateView) {
          videos = state.videos;
          return Scaffold(
            appBar: AppBar(
              title: Text("Video detail"),
            ),
            body: BlocBuilder<VideoBloc, VideoState>(
              builder: (context, state){
                if (state is VideoStateLoading) return Center(child: CircularProgressIndicator());
                if (state is VideoStateSuccess) {
                  return ListView.builder(itemCount: state.videos.length,
                      itemBuilder: (_, i) => ListTile(
                        title: Text(state.videos[i].title),
                        subtitle: Text(state.videos[i].author),
                      ));
                }
                return const Center(child: Text("No videos available"));
              }
            )
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    ));
  }
}
