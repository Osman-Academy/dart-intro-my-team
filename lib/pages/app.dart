import 'package:flutter/material.dart';
import 'package:navigation/pages/home.dart';
import 'package:navigation/pages/detail.dart';

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
    "product": (context) => Detail(),
  },
);
