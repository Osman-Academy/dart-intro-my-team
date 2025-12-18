import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0E0EB14),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFB89B5E),
      secondary: Color(0xFF6A5ACD),
    ),
    textTheme: GoogleFonts.cinzelTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ) ,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    ),
  );
}