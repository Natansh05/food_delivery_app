import 'package:flutter/material.dart';

const List<Color> palette = [
  Color(0xFF7F9CBB), // Lightest
  Color(0xFF49698D),
  Color(0xFF33455B),
  Color(0xFF232C38),
  Color(0xFF202122), // Darkest
];

final ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  scaffoldBackgroundColor: palette[4], // Use darkest as background

  appBarTheme: AppBarTheme(
    backgroundColor: palette[3],
    foregroundColor: palette[0], // Text/icon color on AppBar
    elevation: 0,
  ),

  colorScheme: ColorScheme.dark(
    primary: palette[1],         // Main interactive color
    onPrimary: palette[0],       // Text/icon on primary
    secondary: palette[2],       // Accent color
    onSecondary: palette[0],     // Text/icon on secondary
    surface: palette[3],         // Used for cards/sheets
    onSurface: palette[0],       // Text/icon on surface
  ),

  cardTheme: CardTheme(
    color: palette[3],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Color(0xFFB0BEC5)), // subtle white
    titleLarge: TextStyle(fontWeight: FontWeight.bold),
  ),
);
