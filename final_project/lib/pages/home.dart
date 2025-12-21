import 'package:final_project/bloc/video_bloc.dart';
import 'package:final_project/bloc/video_event.dart';
import 'package:final_project/bloc/video_state.dart';
import 'package:final_project/entities/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Video> videos = [];
  @override
  void initState() {
    super.initState();
    context.read<VideoBloc>().add(VideoLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: TextField(
            decoration: InputDecoration(hintText: "Search videos..."),
            onSubmitted: (query) {
              context.read<VideoBloc>().add(VideoViewEvent(query: query));
            }
          )),
          body: BlocBuilder<VideoBloc, VideoState>(
              builder: (context, state) {
                if (state is VideoStateLoading) return Center(child: CircularProgressIndicator());
                if (state is VideoStateSuccess) {
                  return ListView.builder(
                      itemCount: state.videos.length,
                      itemBuilder: (_, i) => ListTile(
                        title: Text(state.videos[i].title),
                        subtitle: Text(state.videos[i].author),
                      ),
                  );
                }
                return const Center(child: Text("No videos available"));
              })),
    );
  }
}
