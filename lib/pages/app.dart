import 'package:flutter/material.dart';
import 'package:navigation/pages/home.dart';
import 'package:navigation/pages/detail.dart';

var app = MaterialApp(

  title: 'Routing',

  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
  home: const Home(),
  routes: {
    "home": (context) => const Home(),
    "product": (context) => Detail(),
  },
);
