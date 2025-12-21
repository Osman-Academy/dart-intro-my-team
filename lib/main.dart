import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_finder/app.dart';
import 'package:book_finder/common/di/service_locator.dart';
import 'package:book_finder/bloc/book/book_bloc.dart';
import 'package:book_finder/bloc/category/category_bloc.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
      ],
      child: app,
    );
  }
}