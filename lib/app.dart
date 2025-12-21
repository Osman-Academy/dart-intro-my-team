import 'package:flutter/material.dart';
import 'package:book_finder/pages/home.dart';
import 'package:book_finder/pages/detail.dart';
import 'package:book_finder/pages/favorites.dart';

var app = MaterialApp(
  title: 'Book Finder',
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.indigo[50],
      selectedColor: Colors.indigo,
      labelStyle: const TextStyle(fontSize: 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
  ),
  home: const Home(),
  routes: {
    "home": (context) => const Home(),
    "detail": (context) => Detail(),
    "favorites": (context) => const Favorites(),
  },
);