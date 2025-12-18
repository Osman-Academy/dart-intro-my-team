import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTheme {
  static const Color gold = Color(0xFFD4AF37);
  static const Color black = Color(0xFF0B0B0F);
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: black,
    colorScheme: const ColorScheme.dark(
      primary: gold,
      secondary: gold,
      background: black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: black,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.cinzel(
        color: gold,
        fontSize: 22,
        letterSpacing: 2,
    ),
      iconTheme: const IconThemeData(color: gold),
    ),
    textTheme: GoogleFonts.cinzelTextTheme().apply(
      bodyColor:gold,
      displayColor: gold,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: gold.withOpacity(0.6),
        letterSpacing: 1.5,
      ),
      enabledBorder:const UnderlineInputBorder(
        borderSide: BorderSide(color: gold),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: gold, width: 2),
      ),
      prefixIconColor: gold
    ),
    listTileTheme: const ListTileThemeData(
      textColor : gold,
      iconColor:gold,
    ),
  );
}