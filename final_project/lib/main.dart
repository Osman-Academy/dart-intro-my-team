import 'package:final_project/bloc/video_bloc.dart';
import 'package:final_project/common/di/service_locator.dart';
import 'package:final_project/entities/video.dart';
import 'package:final_project/models/video_dto.dart';
import 'package:final_project/pages/app.dart';
import 'package:final_project/usecases/video_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => VideoBloc())],
      child: app
    );
  }
}

