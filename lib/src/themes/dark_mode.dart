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

  colorScheme: ColorScheme.dark(
    surface: Color.fromRGBO(35, 35, 35, 1),
    primary:  Color.fromARGB(255, 214, 214, 213),
    secondary: Color.fromARGB(255, 112, 112, 112), 
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    onSurface: Color.fromARGB(255, 152, 152, 152),
    onSecondary: const Color.fromARGB(255, 48, 48, 48),
    onTertiary: const Color.fromARGB(255, 231, 231, 231)
  ),
);
