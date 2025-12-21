
import 'package:final_project/pages/detail.dart';
import 'package:final_project/pages/home.dart';
import 'package:flutter/material.dart';

var app = MaterialApp(
  // Application name
  title: 'Routing',
  // Application theme data, you can set the colors for the application as
  // you want
  theme: ThemeData(
    // useMaterial3: false,
    primarySwatch: Colors.blue,
  ),
  // A widget which will be started on application startup
  home: const Home(),
  routes: {
    "home": (context) => const Home(),
    "video": (context) => Detail(),
  },
);
